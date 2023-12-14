#!/bin/bash

echo
echo "Actualizando la rama main local..."
echo
git checkout main
git pull
echo
echo "...actualizada"
echo

echo
echo "Actualizando la rama feature/baja-usuario con la rama main remota..."
echo
git checkout feature/baja-usuario
git pull
echo
echo "...actualizada"
echo

echo
echo "Actualizando la rama feature/control-sesion con la rama main remota..."
echo
git checkout feature/control-sesion
git pull
echo
echo "...actualizada"
echo

echo
echo "Actualizando la rama feature/form-usuario con la rama main remota..."
echo
git checkout feature/form-usuario
git pull
echo
echo "...actualizada"
echo

echo
echo "Actualizando la rama feature/seleccionar-tarea con la rama main remota..."
echo
git checkout feature/seleccionar-tarea
git pull
echo
echo "...actualizada"
echo

echo
echo "Actualizando la rama feature/seleccionar-usuario con la rama main remota..."
echo
git checkout feature/seleccionar-usuario
git pull
echo
echo "...actualizada"
echo

echo
echo "Actualizando la rama feature/tarea-fija con la rama main remota..."
echo
git checkout feature/tarea-fija
git pull
echo
echo "...actualizada"
echo

echo
echo "Actualizando la rama feature/tarea-material con la rama main remota..."
echo
git checkout feature/tarea-material
git pull
echo
echo "...actualizada"
echo


echo
echo "Actualizadas todas las ramas con la rama main remota!"
echo
git checkout main
