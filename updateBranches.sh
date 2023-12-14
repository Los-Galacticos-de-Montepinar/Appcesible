#!/bin/bash

echo
echo "Actualizando la rama feature/baja-usuario con la rama main local..."
echo
git checkout feature/baja-usuario
git merge main
git push
echo
echo "...actualizada"
echo

echo
echo "Actualizando la rama feature/control-sesion con la rama main local..."
echo
git checkout feature/control-sesion
git merge main
git push
echo
echo "...actualizada"
echo

echo
echo "Actualizando la rama feature/form-usuario con la rama main local..."
echo
git checkout feature/form-usuario
git merge main
git push
echo
echo "...actualizada"
echo

echo
echo "Actualizando la rama feature/seleccionar-tarea con la rama main local..."
echo
git checkout feature/seleccionar-tarea
git merge main
git push
echo
echo "...actualizada"
echo

echo
echo "Actualizando la rama feature/seleccionar-usuario con la rama main local..."
echo
git checkout feature/seleccionar-usuario
git merge main
git push
echo
echo "...actualizada"
echo

echo
echo "Actualizando la rama feature/tarea-fija con la rama main local..."
echo
git checkout feature/tarea-fija
git merge main
git push
echo
echo "...actualizada"
echo

echo
echo "Actualizando la rama feature/tarea-material con la rama main local..."
echo
git checkout feature/tarea-material
git merge main
git push
echo
echo "...actualizada"
echo


echo
echo "Actualizadas todas las ramas con la rama main local!"
echo
git checkout main
