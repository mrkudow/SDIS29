# PROJET - SDIS 29

## I - CONTEXTE

On veut concevoir une application en capacité de répondre à la gestion des casernes de pompier du Service Départemental d'Incendie et de Secours du Finistère.
Elle doit alors permettre aux responsables des alertes de pouvoir mobiliser les pompiers volontaires nécessaires pour une intervention dans un délai réduit.

---

## II - FONCTIONNALITÉS ATTENDUES

### ACTEURS
- **Chef de centre**  
- **Pompier volontaire**  
- **Responsable d’alerte**

### RÔLE DES ACTEURS

#### _Chef de centre_
- **Mission 1 ✅**
  - Gérer tous les pompiers volontaires de son centre  
  - Visualiser les profils des pompiers volontaires  
  - Modifier les profils des pompiers volontaires  
  - Créer un pompier volontaire  
  - Gérer les paramètres de l’application  

- **Mission 2**
  - Visualiser les disponibilités  
  - Saisir les périodes de garde  


#### _Pompier volontaire_
- **Mission 1 ✅**
  - Visualiser les caractéristiques de leur profil  
  - Modifier les caractéristiques de leur profil  

- **Mission 2**
  - Saisir leurs disponibilités  
  - Voir leurs périodes de garde  


#### _Responsable d’alerte_
- **Mission 2**
  - Enregistrer les éléments d’une intervention  
  - Mobiliser les pompiers volontaires nécessaires pour cette intervention

---

## III -  DESCRIPTION FONCTIONNELLE

### PARCOURS DE NAVIGATION

![Parcours de navigation](/doc/ParcoursNavigation.png)

### DIAGRAMME DES CAS D'UTILISATION

![Diagramme des cas d'utilisation](/doc/CasUtilisation.png)

### DESCRIPTION DES CAS D'UTILISATION

**A. S’authentifier**
> **Objectif :** Les utilisateurs doivent pouvoir s’authentifier et être spécifiquement redirigés vers les pages correspondant à leur rôle.
>
> **Acteurs :**  
> - Chef de centre  
> - Pompier volontaire  
> - Responsable d’alerte
>
> **Scénario(s) :**  
> 1. Lorsqu’un utilisateur veut accéder à l’application, il passe obligatoirement par une page d’authentification.  
> 2. Il saisit ses identifiants qui, s’ils sont validés, lui permettent d’accéder à l’application **dans les limites de son rôle**.
> 3. Si l’utilisateur n’existe pas ou si les identifiants sont invalides, il reste sur la page d’authentification et n’accède pas aux fonctionnalités de l’application.
>
> **Redirections selon le rôle :**  
> - **Chef de centre :** redirection automatique vers la page de gestion de sa caserne.  
> - **Pompier volontaire :** redirection automatique vers sa page de profil.  
> - **Responsable d’alerte :** redirection automatique vers la page de gestion des interventions (Mission 2).
    
**B. Gestion des profils**
> **Objectif :**  
> Les utilisateurs doivent pouvoir accéder à leur profil et éditer leurs informations quand nécessaire.  
>
> **Acteurs :**  
> - Chef de centre  
> - Pompier volontaire  
> - Responsable d’alerte  
>
> **Scénario(s) :**  
> 1. Lorsqu’un utilisateur accède à sa page de profil, il peut **visualiser toutes les informations le concernant**.  
> 2. Depuis cette page, il peut **éditer ses propres informations** si cela est autorisé par son rôle.  
> 3. Le **Chef de centre** peut **consulter les profils des pompiers volontaires** de sa caserne.  
> 4. Sur ces profils, il peut **modifier certaines informations** relatives à ses pompiers.  
> 5. Le **Chef de centre** a également la possibilité de **créer de nouveaux profils de pompiers volontaires**.

**C. Gestion des interventions**
> **Objectif :**  
> Les responsables d’alerte doivent pouvoir gérer les interventions des pompiers volontaires quand nécessaire.  
>
> **Acteurs :**  
> - Responsable d’alerte  
>
> **Scénario(s) :**  
> 1. Lorsqu’un **responsable d’alerte** accède à la page d’intervention, il peut **visualiser l’ensemble des interventions** qu’il a créées, qu’elles soient **en cours** ou **passées**.  
> 2. Il peut **créer de nouvelles interventions** et y **mobiliser les pompiers volontaires nécessaires**.  
> 3. Il doit pouvoir **commenter en temps réel les interventions en cours** afin d’apporter des précisions ou des consignes supplémentaires lorsque nécessaire.

**D. Gestion des plannings**
> **Objectif :**
> Les chefs de centre et les pompiers volontaires doivent pouvoir gérer les plannings de garde et de disponibilité.
>
> **Acteurs :**
> - Chef de centre
> - Pompier volontaire
>
> **Scénario(s) :**
> 1. Le **pompier volontaire** peut accéder à son planning personnel et y **saisir ses disponibilités** pour les périodes à venir.
> 2. Le **chef de centre** peut accéder au planning de sa caserne et y **saisir les périodes de garde** pour les pompiers volontaires.

## IV - ÉVOLUTION DE LA BASE DE DONNÉES

**MISSION 1**

Avant
![Schéma de la base de données (avant)](/doc/BaseDonneesInitiale.png)

Après
![Schéma de la base de données (après)](/doc/BaseDonneesMission1.png)

**MISSION 2**

Avant
![Schéma de la base de données (avant)](/doc/BaseDonneesMission1.png)

Après
![Schéma de la base de données (après)](/doc/BaseDonneesMission2.png)

Évènement - Génération automatique de dates
Fréquence: 1 fois par semaine
Détail:
  - Récupération du lundi de la semaine à suivre
  - Insertion des 7 jours suivants partants du lundi récupéré pour chaque pompier

## V - STRUCTURE DU PROJET

### ARCHITECTURE APPLICATIVE

**Outils utilisés:**
- Conception des programmes:
  - Jakarta EE *(développement de l'application en Java)*
  - NetBeans *(développement applicatif)*
  - Visual Studio Code *(résolution des conflits Git)*
- Gestion des données
  - MariaDB *(gestion de la base de données)*
  - phpMyAdmin *(support interactif dans la gestion de la base de données)*
- Modélisation
  - Draw .IO *(schématisation)*
- Hébergement
  - VirtualBox *(simulation du serveur de base de données)*
  - Payara *(serveur d'application)*
- Collaboration
  - Gitea *(centralisation du code source de l'application)*
  - Google Drive *(partage des documents relatifs à l'application)*

### STRUCTURE DES RÉPERTOIRES ET FICHIERS

![Arborescence des répertoires et fichiers](/doc/Arborescence.png)

### CHARTE GRAPHIQUE