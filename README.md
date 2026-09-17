# Carta Digital

Trabajo Práctico Final de la materia Ingeniería en Software. Este desarrollo corresponde al grupo: `while(true) {}`

## TP N° 1: Linter — Gestión de la Calidad del Software

### 1. ¿Cómo funciona?

#### 1.1 Protección de ramas

La protección se implementó mediante un **ruleset** de GitHub llamado `proteccion-ramas`, en estado **Active** y con la lista de excepciones (*bypass list*) vacía. Esto último es deliberado: al no haber colaboradores exceptuados, las reglas se aplican también al dueño del repositorio, que de otro modo podría saltearlas.

El ruleset apunta a dos ramas, `main` y `develop`, y aplica tres reglas:

| Regla | Efecto |
| :--- | :--- |
| `pull_request` | Ningún commit llega a la rama si no pasó por una Pull Request |
| `non_fast_forward` | Bloquea los *force push*, que permitirían reescribir el historial |
| `deletion` | Impide borrar la rama |

**Cómo opera el bloqueo.** Cuando alguien intenta hacer `git push` directamente sobre `main` o `develop`, el rechazo lo produce el servidor de GitHub al recibir el push: la operación falla y los commits nunca llegan al repositorio remoto. No es una convención acordada entre los integrantes del grupo, sino un control técnico que no depende de la disciplina de quien ejecuta el push.

**Por qué se protegen dos ramas y no solo `main`.** Las reglas de GitHub se aplican por rama, no por repositorio. La consigna exige proteger `main`, pero el flujo real de trabajo de este proyecto ocurre sobre `develop`, que es donde se integran las Pull Requests. Si se protegiera únicamente `main`, una PR dirigida a `develop` ejecutaría igual el workflow de linteo y mostraría el check en rojo, pero podría mergearse de todas formas, porque ninguna regla lo impediría. El gate sería informativo en lugar de bloqueante.

**Estado actual.** La regla `Require status checks to pass` todavía no está habilitada: GitHub solo permite marcar como requerido un check que ya se ejecutó al menos una vez, de modo que esa configuración se completa después de abrir la primera Pull Request con el workflow de linteo (ver 1.3).
