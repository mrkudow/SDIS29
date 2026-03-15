/* 
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Other/javascript.js to edit this template
 */
let planningDispos = document.getElementsByClassName('planning-dispos');

function etatPlanning(planning) {
    let value = planning.getAttribute('data-dispo');
    switch (value) {
        case '0': // Non disponible
            planning.style.backgroundColor = '#4d4d4d';
            planning.innerHTML = ".";
            // On rend le point invisible
            planning.style.color = '#4d4d4d';
            planning.classList.add('inactif');
            break;
        case '1': // Disponible
            planning.style.backgroundColor = '#fff';
            planning.innerHTML = ".";
            planning.style.color = '#fff';
            planning.value = '3';
            break;
        case '2': // Au travail
            planning.style.backgroundColor = '#bbbb1aff';
            planning.style.backgroundImage = 'repeating-linear-gradient(90deg, transparent, transparent 4px, rgba(77, 77, 77, 0.5) 4px, rgba(77, 77, 77, 0.5) 8px)';
            planning.innerHTML = ".";
            planning.style.color = '#bbbb1aff';
            planning.value = '4';
            break;
        case '3': // De garde
            planning.style.backgroundColor = '#fff';
            planning.innerHTML = ".";
            planning.style.color = '#fff';
            planning.value = '1';
            break;
        case '4': // Au travail et de garde
            planning.style.backgroundColor = '#bbbb1aff';
            planning.style.backgroundImage = 'repeating-linear-gradient(90deg, transparent, transparent 4px, rgba(77, 77, 77, 0.5) 4px, rgba(77, 77, 77, 0.5) 8px)';
            planning.innerHTML = ".";
            planning.style.color = '#bbbb1aff';
            planning.value = '2';
            break;
        default:
            planning.innerHTML = '.';
            break;
    }

    switch (planning.checked) {
        case true:
            planning.style.color = "#000";
            planning.innerHTML = "X";
            break;
        default:
            planning.innerHTML = ".";
            break;
    }
}

document.addEventListener('DOMContentLoaded', function () {
    for (planning of planningDispos) {
        etatPlanning(planning);
        planning.addEventListener('click', function () {
            etatPlanning(this);
        });
    }
});