<%-- 
    Document   : profilVue
    Created on : 6 oct. 2025, 15:44:22
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
            <c:choose>
                <c:when test="${action == 'caserne'}">
                    <h1>Profil du pompier</h1>
                </c:when>
                <c:otherwise>
                    <h1>Mon profil de pompier</h1>
                </c:otherwise>
            </c:choose>
            <form method="post" action="${action}">
                <section>
                    <h2>Identité</h2>
                    <dl>
                        <dt>Identifiant</dt>
                        <dd>#${pompier.getId()}</dd>

                        <dt>Nom complet</dt>
                        <dd>${pompier.getNom()} ${pompier.getPrenom()}</dd>
                    </dl>
                </section>
                <c:choose>
                    <c:when test="${action != 'caserne' && profilEditing}">
                    </c:when>
                    <c:otherwise>
                        <section>
                            <h2>Informations professionnelles</h2>
                            <dl>
                                <dt>Statut</dt>
                                <dd>
                                    <c:choose>
                                        <c:when test="${profilEditing && sessionScope.role == 'chef de centre'}">
                                            <select name="statut">
                                                <option value="">${pompier.getStatutName()} (actuel)</option>
                                                <c:forEach var="statut" items="${statuts}">
                                                    <c:if test="${statut[1] != pompier.getStatutName()}">
                                                        <option value="${statut[0]}">${statut[1]}</option>
                                                    </c:if>
                                                </c:forEach>
                                            </select>
                                        </c:when>
                                        <c:otherwise>
                                            ${pompier.getStatutName()}
                                        </c:otherwise>
                                    </c:choose>
                                </dd>
                                <dt>Type de personnel</dt>
                                <dd>
                                    <c:choose>
                                        <c:when test="${profilEditing && sessionScope.role == 'chef de centre'}">
                                            <select name="personnel">
                                                <option value="">${pompier.getPersonnelName()} (actuel)</option>
                                                <c:forEach var="personnel" items="${personnels}">
                                                    <c:if test="${personnel[1] != pompier.getPersonnelName()}">
                                                        <option value="${personnel[0]}">${personnel[1]}</option>
                                                    </c:if>
                                                </c:forEach>
                                            </select>
                                        </c:when>
                                        <c:otherwise>
                                            ${pompier.getPersonnelName()}
                                        </c:otherwise>
                                    </c:choose>
                                </dd>

                                <dt>Grade</dt>
                                <dd>
                                    <c:choose>
                                        <c:when test="${profilEditing && sessionScope.role == 'chef de centre'}">
                                            <select name="grade">
                                                <option value="">${pompier.getGradeName()} (actuel)</option>
                                                <c:forEach var="grade" items="${grades}">
                                                    <c:if test="${grade[1] != pompier.getGradeName()}">
                                                        <option value="${grade[0]}">${grade[1]}</option>
                                                    </c:if>
                                                </c:forEach>
                                            </select>
                                        </c:when>
                                        <c:otherwise>
                                            ${pompier.getGradeName()}
                                        </c:otherwise>
                                    </c:choose>
                                </dd>
                                <dt>Caserne</dt>
                                <dd>${pompier.getLaCaserne().getNom()} (${pompier.getLaCaserne().getAdresse()})</dd>
                            </dl>
                        </section>
                    </c:otherwise>
                </c:choose>

                <section>
                    <h2>Coordonnées</h2>
                    <dl>
                        <dt>Adresse mail</dt>
                        <dd>
                            <c:choose>
                                <c:when test="${profilEditing}">
                                    <input type="text" name="mail" placeholder="${pompier.getMail()}">
                                </c:when>
                                <c:otherwise>
                                    ${pompier.getMail()}
                                </c:otherwise>
                            </c:choose>
                        </dd>

                        <dt>Adresse postale</dt>
                        <dd>
                            <c:choose>
                                <c:when test="${profilEditing}">
                                    <input type="text" name="adresse" placeholder="${pompier.getAdresse()}">
                                </c:when>
                                <c:otherwise>
                                    ${pompier.getAdresse()}
                                </c:otherwise>
                            </c:choose>
                        </dd>

                        <dt>Code postal</dt>
                        <dd>
                            <c:choose>
                                <c:when test="${profilEditing}">
                                    <input type="text" name="cp" placeholder="${pompier.getCp()}">
                                </c:when>
                                <c:otherwise>
                                    ${pompier.getCp()}
                                </c:otherwise>
                            </c:choose>
                        </dd>

                        <dt>Ville</dt>
                        <dd>
                            <c:choose>
                                <c:when test="${profilEditing}">
                                    <input type="text" name="ville" placeholder="${pompier.getVille()}">
                                </c:when>
                                <c:otherwise>
                                    ${pompier.getVille()}
                                </c:otherwise>
                            </c:choose>
                        </dd>
                    </dl>
                </section>

                <c:choose>
                    <c:when test="${action != 'caserne' && profilEditing}">
                    </c:when>
                    <c:otherwise>
                        <section>
                            <h2>Historique</h2>
                            <dl>
                                <dt>Date d'enregistrement</dt>
                                <dd>${pompier.getDateEnreg()}</dd>

                                <dt>Dernière modification</dt>
                                <dd>${pompier.getDateModif()}</dd>
                            </dl>
                        </section>
                    </c:otherwise>
                </c:choose>

                <div class='btn-groupe'>
                    <c:choose>
                        <c:when test="${profilEditing}">
                            <button name="edit" type="submit" value="1">Enregistrer une modification</button>
                            <button name="edit" type="submit" value="0">Annuler les modifications</button>
                        </c:when>
                        <c:otherwise>
                            <button name="edit" type="submit" value="2">Modifier le profil</button>
                            <c:if test="${action == 'caserne'}">
                                <button name="edit" type="submit" value="3">Retour à la caserne</button>
                            </c:if>
                        </c:otherwise>
                    </c:choose>
                </div>
            </form>
        </main>

        <main>
            <h1>Disponibilités</h1>
            <section class="disponibilite-section">
                <h2 id="s1H2">Semaine du ${start1} au ${end1}</h2>
                <div id="s1Div">
                    <table class="disponibilite">
                        <tr>
                            <th>Date</th>
                            <th>Nuit</th>
                            <th>Matinee</th>
                            <th>Après-midi</th>
                            <th>Soirée</th>
                        </tr>

                        <c:forEach var="journee" items="${pompier.getDisponibilites(true)}">
                            <tr>
                                <!-- Date -->
                                <td>${journee.getDateToString()}</td>

                                <!-- Nuit -->
                                <td class="journee">
                                    <div class="horaire" id="dispo${journee.getNuit()}">
                                        <span>${parametres.readDisponible(journee.getNuit())[1]}</span>
                                    </div>
                                </td>

                                <!-- Matinée -->
                                <td class="journee">
                                    <div class="horaire" id="dispo${journee.getMatinee()}">
                                        <span>${parametres.readDisponible(journee.getMatinee())[1]}</span>
                                    </div>
                                </td>

                                <!-- Après-midi -->
                                <td class="journee">
                                    <div class="horaire" id="dispo${journee.getApresMidi()}">
                                        <span>${parametres.readDisponible(journee.getApresMidi())[1]}</span>
                                    </div>
                                </td>

                                <!-- Soirée -->
                                <td class="journee">
                                    <div class="horaire" id="dispo${journee.getSoiree()}">
                                        <span>${parametres.readDisponible(journee.getSoiree())[1]}</span>
                                    </div>
                                </td>
                            </tr>
                        </c:forEach>
                    </table>
                </div>
            </section>
            <section class="disponibilite-section">
                <h2 id="s2H2">Semaine du ${start2} au ${end2}</h2>
                <div id="s2Div">
                    <table class="disponibilite">
                        <tr>
                            <th>Date</th>
                            <th>Nuit</th>
                            <th>Matinee</th>
                            <th>Après-midi</th>
                            <th>Soirée</th>
                            <th>Validation</th>
                        </tr>

                        <c:forEach var="journee" items="${pompier.getDisponibilites(false)}">
                            <tr>
                            <form method="post">
                                <!-- Date -->
                                <td>${journee.getDateToString()}</td>

                                <!-- Nuit -->
                                <td class="journee">
                                    <div class="horaire" id="dispo${journee.getNuit()}">
                                        <c:choose>
                                            <c:when test="${action == 'caserne'}">
                                                ${parametres.readDisponible(journee.getNuit())[1]}
                                            </c:when>
                                            <c:otherwise>
                                                <select name="nuit">
                                                    <option class="dispo${journee.getNuit()}" value="${journee.getNuit()}">${parametres.readDisponible(journee.getNuit())[1]}</option>
                                                    <c:forEach items="${parametres.readAllDisponible()}" var="disponible">
                                                        <c:if test="${disponible[0] != journee.getNuit()}">
                                                            <c:if test="${!disponible[1].equals('Garde') && !disponible[1].equals('Au travail-Garde')}">
                                                                <option class="dispo${disponible[0]}" value="${disponible[0]}">${disponible[1]}</option>
                                                            </c:if>
                                                        </c:if>
                                                    </c:forEach>
                                                </select>
                                            </c:otherwise>
                                        </c:choose>
                                    </div>
                                </td>

                                <!-- Matinée -->
                                <td class="journee">
                                    <div class="horaire" id="dispo${journee.getMatinee()}">
                                        <c:choose>
                                            <c:when test="${action == 'caserne'}">
                                                ${parametres.readDisponible(journee.getMatinee())[1]}
                                            </c:when>
                                            <c:otherwise>
                                                <select name="matinee">
                                                    <option class="dispo${journee.getMatinee()}" value="${journee.getMatinee()}">${parametres.readDisponible(journee.getMatinee())[1]}</option>
                                                    <c:forEach items="${parametres.readAllDisponible()}" var="disponible">
                                                        <c:if test="${disponible[0] != journee.getMatinee()}">
                                                            <c:if test="${!disponible[1].equals('Garde') && !disponible[1].equals('Au travail-Garde')}">
                                                                <option class="dispo${disponible[0]}" value="${disponible[0]}">${disponible[1]}</option>
                                                            </c:if>
                                                        </c:if>
                                                    </c:forEach>
                                                </select>
                                            </c:otherwise>
                                        </c:choose>
                                    </div>
                                </td>

                                <!-- Après-midi -->
                                <td class="journee">
                                    <div class="horaire" id="dispo${journee.getApresMidi()}">
                                        <c:choose>
                                            <c:when test="${action == 'caserne'}">
                                                ${parametres.readDisponible(journee.getApresMidi())[1]}
                                            </c:when>
                                            <c:otherwise>
                                                <select name="apres_midi">
                                                    <option class="dispo${journee.getApresMidi()}" value="${journee.getApresMidi()}">${parametres.readDisponible(journee.getApresMidi())[1]}</option>
                                                    <c:forEach items="${parametres.readAllDisponible()}" var="disponible">
                                                        <c:if test="${disponible[0] != journee.getApresMidi()}">
                                                            <c:if test="${!disponible[1].equals('Garde') && !disponible[1].equals('Au travail-Garde')}">
                                                                <option class="dispo${disponible[0]}" value="${disponible[0]}">${disponible[1]}</option>
                                                            </c:if>
                                                        </c:if>
                                                    </c:forEach>
                                                </select>
                                            </c:otherwise>
                                        </c:choose>
                                    </div>
                                </td>

                                <!-- Soirée -->
                                <td class="journee">
                                    <div class="horaire" id="dispo${journee.getSoiree()}">
                                        <c:choose>
                                            <c:when test="${action == 'caserne'}">
                                                ${parametres.readDisponible(journee.getSoiree())[1]}
                                            </c:when>
                                            <c:otherwise>
                                                <select name="soiree">
                                                    <option class="dispo${journee.getSoiree()}" value="${journee.getSoiree()}">${parametres.readDisponible(journee.getSoiree())[1]}</option>
                                                    <c:forEach items="${parametres.readAllDisponible()}" var="disponible">
                                                        <c:if test="${disponible[0] != journee.getSoiree()}">
                                                            <c:if test="${!disponible[1].equals('Garde') && !disponible[1].equals('Au travail-Garde')}">
                                                                <option class="dispo${disponible[0]}" value="${disponible[0]}">${disponible[1]}</option>
                                                            </c:if>
                                                        </c:if>
                                                    </c:forEach>
                                                </select>
                                            </c:otherwise>
                                        </c:choose>

                                    </div>
                                </td>
                                <td>
                                    <input type="hidden" name="date" value="${journee.getDate()}">
                                    <button name="edit" value="4" type="submit">Valider</button>
                                </td>
                            </form>
                            </tr>
                        </c:forEach>
                    </table>
                </div>


            </section>
        </main>
        <%@include file="jspf/footer.jspf" %>
    </body>
</html>