<%-- 
    Document   : caserneVue
    Created on : 9 oct. 2025, 11:10:55
    Author     : steve.maingana
--%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <%@include file="jspf/entete.jspf" %>
    <body>
        <%@include file="jspf/header.jspf" %>
        <main>
            <h1>Caserne ${caserne.getNom()} | (#${caserne.getId()})</h1>
            <section>
                <h2>Informations générales</h2>
                <dl>
                    <dt>Adresse</dt>
                    <dd>${caserne.getAdresse()}</dd>
                    <dt>Téléphone</dt>
                    <dd>${caserne.getTel()}</dd>
                    <dt>Groupement</dt>
                    <dd>${caserne.getGroupement()}</dd>
                </dl>
            </section>
            <section>
                <h2>Les pompiers</h2>
                <div class="table-deroulante">
                    <table>
                        <tr>
                            <th>ID</th>
                            <th>Pompier</th>
                            <th>Grade</th>
                            <th>Action</th>
                        </tr>
                        <c:forEach var="pompier" items="${caserne.getPompiers()}">
                            <form method="post" action="caserne">
                                <tr>
                                    <td>${pompier.getId()}</td>
                                    <td>${pompier.getNom()} ${pompier.getPrenom()}</td>
                                    <td>${pompier.getGradeName()}</td>
                                    <td><button name="pompier" type="submit" value="${pompier.getId()}">Consulter</button></td>
                                </tr>
                            </form>
                        </c:forEach>
                    </table>
                </div>
            </section>
            <section>
                <h2>Planning - Pompiers volontaires</h2>
                <form method="post" action="caserne">
                    <div class="table-deroulante">
                        <table class="planning inactif">
                            <tr class="planning-dates">
                                <td colspan="2">Semaine ${numeroSemaine1}</td>
                                <c:forEach items="${semaine1}" var="jour">
                                    <td>${jour[1]}</td>
                                </c:forEach>
                            </tr>
                            <tr>
                                <th>VOLONTAIRE</th>
                                <th>N° bip</th>
                                    <c:forEach items="${semaine1}" var="jour">
                                    <td>
                                        <div class="planning-contenu">
                                            <span class="planning-horaires">N</span>
                                            <span class="planning-horaires">M</span>
                                            <span class="planning-horaires">A</span>
                                            <span class="planning-horaires">S</span>
                                        </div>
                                    </td>
                                </c:forEach>
                            </tr>
                            <c:forEach items="${caserne.getPompiers()}" var="pompier">
                                <tr>
                                    <td>${pompier.getNom()} ${pompier.getPrenom()}</td>
                                    <td>${pompier.getBip()}</td>
                                    <c:forEach items="${semaine1}" var="jour">
                                        <td>
                                            <div class="planning-contenu">

                                                <form method="post" action="caserne">
                                                    <input type="hidden" name="pompier" value="${pompier.getId()}">
                                                    <input type="hidden" name="date" value="${jour[0]}">
                                                    <input type="hidden" name="edit" value="4">
                                                    <input type="hidden" name="horaire" value="nuit">
                                                    <input type="checkbox" class="planning-dispos" 
                                                           data-dispo="${pompier.getDisponibilite(true, jour[0]).getNuit()}"
                                                           name="valeur" 
                                                           ${pompier.getDisponibilite(true, jour[0]).getNuit() > 2 ? 'checked' : ''}>
                                                    <input type="hidden" name="etat" value="${pompier.getDisponibilite(true, jour[0]).getNuit()}">
                                                </form>
                                                <form method="post" action="caserne">
                                                    <input type="hidden" name="pompier" value="${pompier.getId()}">
                                                    <input type="hidden" name="date" value="${jour[0]}">
                                                    <input type="hidden" name="edit" value="4">
                                                    <input type="hidden" name="horaire" value="matinee">
                                                    <input type="checkbox" class="planning-dispos" 
                                                           data-dispo="${pompier.getDisponibilite(true, jour[0]).getMatinee()}"
                                                           name="valeur"
                                                           ${pompier.getDisponibilite(true, jour[0]).getMatinee() > 2 ? 'checked' : ''}>
                                                    <input type="hidden" name="etat" value="${pompier.getDisponibilite(true, jour[0]).getMatinee()}">
                                                </form>
                                                <form method="post" action="caserne">
                                                    <input type="hidden" name="pompier" value="${pompier.getId()}">
                                                    <input type="hidden" name="date" value="${jour[0]}">
                                                    <input type="hidden" name="edit" value="4">
                                                    <input type="hidden" name="horaire" value="apres_midi">
                                                    <input type="checkbox" class="planning-dispos" 
                                                           data-dispo="${pompier.getDisponibilite(true, jour[0]).getApresMidi()}"
                                                           name="valeur" 
                                                           ${pompier.getDisponibilite(true, jour[0]).getApresMidi() > 2 ? 'checked' : ''}>
                                                    <input type="hidden" name="etat" value="${pompier.getDisponibilite(true, jour[0]).getApresMidi()}">
                                                </form>
                                                <form method="post" action="caserne">
                                                    <input type="hidden" name="pompier" value="${pompier.getId()}">
                                                    <input type="hidden" name="date" value="${jour[0]}">
                                                    <input type="hidden" name="edit" value="4">
                                                    <input type="hidden" name="horaire" value="soiree">
                                                    <input type="checkbox" class="planning-dispos" 
                                                           data-dispo="${pompier.getDisponibilite(true, jour[0]).getSoiree()}"
                                                           name="valeur" 
                                                           ${pompier.getDisponibilite(true, jour[0]).getSoiree() > 2 ? 'checked' : ''}>
                                                    <input type="hidden" name="etat" value="${pompier.getDisponibilite(true, jour[0]).getSoiree()}">
                                                </form>
                                            </div>
                                        </td>
                                    </c:forEach>
                                </tr>
                            </c:forEach>
                        </table>
                    </div>
                    <div class="table-deroulante">
                        <table class="planning">
                            <tr class="planning-dates">
                                <td colspan="2">Semaine ${numeroSemaine2}</td>
                                <c:forEach items="${semaine2}" var="jour">
                                    <td>${jour[1]}</td>
                                </c:forEach>
                            </tr>
                            <tr>
                                <th>VOLONTAIRE</th>
                                <th>N° bip</th>
                                    <c:forEach items="${semaine2}" var="jour">
                                    <td>
                                        <div class="planning-contenu">
                                            <span class="planning-horaires">N</span>
                                            <span class="planning-horaires">M</span>
                                            <span class="planning-horaires">A</span>
                                            <span class="planning-horaires">S</span>
                                        </div>
                                    </td>
                                </c:forEach>
                            </tr>
                            <c:forEach items="${caserne.getPompiers()}" var="pompier">
                                <tr>
                                    <td>${pompier.getNom()} ${pompier.getPrenom()}</td>
                                    <td>${pompier.getBip()}</td>
                                    <c:forEach items="${semaine2}" var="jour">
                                        <td>
                                            <div class="planning-contenu">

                                                <form method="post" action="caserne">
                                                    <input type="hidden" name="pompier" value="${pompier.getId()}">
                                                    <input type="hidden" name="date" value="${jour[0]}">
                                                    <input type="hidden" name="edit" value="4">
                                                    <input type="hidden" name="horaire" value="nuit">
                                                    <input type="checkbox" class="planning-dispos" 
                                                           data-dispo="${pompier.getDisponibilite(false, jour[0]).getNuit()}"
                                                           name="valeur" 
                                                           ${pompier.getDisponibilite(false, jour[0]).getNuit() > 2 ? 'checked' : ''}>
                                                    <input type="hidden" name="etat" value="${pompier.getDisponibilite(false, jour[0]).getNuit()}">
                                                </form>
                                                <form method="post" action="caserne">
                                                    <input type="hidden" name="pompier" value="${pompier.getId()}">
                                                    <input type="hidden" name="date" value="${jour[0]}">
                                                    <input type="hidden" name="edit" value="4">
                                                    <input type="hidden" name="horaire" value="matinee">
                                                    <input type="checkbox" class="planning-dispos" 
                                                           data-dispo="${pompier.getDisponibilite(false, jour[0]).getMatinee()}"
                                                           name="valeur"
                                                           ${pompier.getDisponibilite(false, jour[0]).getMatinee() > 2 ? 'checked' : ''}>
                                                    <input type="hidden" name="etat" value="${pompier.getDisponibilite(false, jour[0]).getMatinee()}">
                                                </form>
                                                <form method="post" action="caserne">
                                                    <input type="hidden" name="pompier" value="${pompier.getId()}">
                                                    <input type="hidden" name="date" value="${jour[0]}">
                                                    <input type="hidden" name="edit" value="4">
                                                    <input type="hidden" name="horaire" value="apres_midi">
                                                    <input type="checkbox" class="planning-dispos" 
                                                           data-dispo="${pompier.getDisponibilite(false, jour[0]).getApresMidi()}"
                                                           name="valeur" 
                                                           ${pompier.getDisponibilite(false, jour[0]).getApresMidi() > 2 ? 'checked' : ''}>
                                                    <input type="hidden" name="etat" value="${pompier.getDisponibilite(false, jour[0]).getApresMidi()}">
                                                </form>
                                                <form method="post" action="caserne">
                                                    <input type="hidden" name="pompier" value="${pompier.getId()}">
                                                    <input type="hidden" name="date" value="${jour[0]}">
                                                    <input type="hidden" name="edit" value="4">
                                                    <input type="hidden" name="horaire" value="soiree">
                                                    <input type="checkbox" class="planning-dispos" 
                                                           data-dispo="${pompier.getDisponibilite(false, jour[0]).getSoiree()}"
                                                           name="valeur" 
                                                           ${pompier.getDisponibilite(false, jour[0]).getSoiree() > 2 ? 'checked' : ''}>
                                                    <input type="hidden" name="etat" value="${pompier.getDisponibilite(false, jour[0]).getSoiree()}">
                                                </form>
                                            </div>
                                        </td>
                                    </c:forEach>
                                </tr>
                            </c:forEach>
                        </table>
                    </div>
                </form>
            </section>
            <div class='btn-groupe'>
                <a class="a-btn" href='nouveau-pompier'>Enregistrer un pompier</a>
                <a class="a-btn">Journal d'activité</a>
            </div>
        </main>
        <%@include file="jspf/footer.jspf" %>
        <script src="javascript/calendrier.js" defer></script>
        <script>
            document.querySelectorAll('.planning-dispos').forEach(bouton => {
                bouton.addEventListener('change', () => {
                    bouton.closest('form').submit();
                });
            });
        </script>
    </body>
</html>