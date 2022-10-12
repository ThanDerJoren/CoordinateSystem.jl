module CoordinateSystem
# Daten import
# über ] in der REPL "add PKg" Pkg hinzufügen

#=
An Folgenden Stellen, dass programm anpassen, wenn .PT importieren
Kapitel "#Zeilen(vektorelemente) der Datei spliten"
    Zeile 4  -> an was für einem Zeichen soll gesplittet werden
Kapitel "#String->Float64 && Aus 1D Array in einem 1D Array, ein 2D Array erstellen"
    Zeile 1 -> welche länge, soll die 2. Dimension (Spalten pro Zeile) bekommen (manchmal untershciedlich viele Aufteilungen innerhalb einer Zeile)
    Zeile 2 -> in welcher Zeile (for Loop i) soll begonnen werden zu parsen (zu beginn noch buchstraben, die übersprungen werden müssen)
Kapitel "#Punkte Plotten"
    Zeile 1: welche Spalte ist x und y? (bei .PT dateien wird am anfang noch die Punknummer angegeben)
=#
#Auslesen einer Datei
using Pkg
using Plots

open("C:/Users/Julek/Nextcloud/A Verkehrsingenieurwesen/ifev/ProgrammRadienBestimmen/VerändertStreckenachse freihand erfasst (aus ProVI) - Kopie.PT") do dataVector
#DateiPfad: den nutzen: / und nicht den nutzen: \
dataVector = readlines(dataVector)#jede Zeiler wird einzeln abgespeichert -> Vektor

println("hier sollten Daten folgen:") #testkrams
println(dataVector)# zur kontrolle
#=
jede Zeile des Dokuments ist jetzt eine Spalte in einem array.
Die ersten beiden Zeilen sind uninteressant.
Danach soll jede Zeile nochmal in einzlne Spalten aufgeteilt werden.
=#

#for rows in 1:length(dataVector) # length und nicht size ich glaube weil vector und nicht array
    
#Zeilen(vektorelemente) der Datei spliten
println("test2")
dataSplit = Array{Vector{SubString{String}}}(undef, length(dataVector)) # Funktion split gibt den DatenTyp SubString{String} aus. "Karteikasten in einzelner Schublade"
for rows in 1:length(dataVector) # length und nicht size ich glaube weil vector und nicht array
    dataSplit[rows]= split(dataVector[rows], "  ") #hier angeben an was für einem Zeichen gesplitet werden soll
end

#String->Float64 && Aus 1D Array in einem 1D Array, ein 2D Array erstellen
dataArray = Array{Float64,2}(undef,size(dataSplit,1),length(dataSplit[5]))# Problem: länge der substrings später vielleicht unterschiedlich lang Lösung: gibt es methode, die längsten substring filtert?
for i in 2:size(dataSplit,1) #3, weil die ersten beiden Zeilen ztext sind -> wie anders abfangen?
    for j in 1:length(dataSplit[i])
       dataArray[i,j]= parse(Float64, dataSplit[i][j])
    end
end

#Print zur Kontrolle
for i in 1:size(dataSplit,1)
    for j in 1:length(dataSplit[i])
        print(dataSplit[i][j], "\t")#zwei Eckige klammern: 1. für das SubString 2. für die Stelle im SubString
    end
    print("\n")
end
print("\n")
for i in 1:size(dataSplit,1)
    for j in 1:length(dataSplit[i])
        print(dataArray[i,j], "\t")
    end
    print("\n")
end

#Punkte Plotten
#eigentlich x=dataArray[:,2]; y=dataArray[:,3], aber im Moment im ersten Element noch eine 0, das macht die Skalierung kaputt
x=dataArray[2:size(dataArray,1),2]; y=dataArray[2:size(dataArray,1),3]   #x=aus jeder(:) Zeile(i) nehme ich die erste Spalte, y=aus jeder(:) Zeile(i) nehme ich die zweite Spalte

#=
#hier sieht man einfach nur die Punkte
display(plot(x,y,                    #display ist wichtig
    seriestype = :scatter,           # Punkte statt linien
    title = "Punkte aus Datei"))
=#
#hier sieht man zusätzlich die Linien, die die Punkte verbindet
display(plot(x,y, title = "Punkte aus Datei")) #Linien werden geplottet
display(scatter!(x,y,)) #Scatter: erstellt Punkte, ! zeigt an, dass es zusätzlich auf den bestehenden Plot gelegt werden soll

end #open Warum kann man das erst ganz am Ende schließen?
end


#Anleitung zum Plotten
#=using Plots
x = 1:10; y = rand(10); # kinda array? speichert auf jeden Falls 10 zahlen
# das semikolon ; ist wichtig!
#display(plot(x,y)) #display ist wichtig
display(plot(x,y, 
    seriestype = :scatter, # Punkte statt linien
    title = "Random Punkte"))
=#