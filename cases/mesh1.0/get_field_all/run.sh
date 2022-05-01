decomposePar -force
renumberMesh -overwrite
foamDictionary system/controlDict -entry writeInterval -set 100
foamDictionary system/controlDict -entry endTime -set 1500
foamDictionary constant/chemistryProperties -entry chemistry -set off

mpirun -np 4 reactingFoam -parallel > log.parallel 2>&1

foamDictionary system/controlDict -entry writeInterval -set 100
foamDictionary system/controlDict -entry endTime -set 5000
foamDictionary constant/chemistryProperties -entry chemistry -set on

mpirun -np 4 reactingFoam -parallel > log.parallel 2>&1

reconstructPar
zip -r package.zip * >/dev/null 2>&1
