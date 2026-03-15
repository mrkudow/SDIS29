<%-- 
    Document   : nouveauPompierVue
    Created on : 14 oct. 2025, 22:13:52
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
            <h1>Enregistrement d'un pompier</h1>
            <form method="post" action="nouveau-pompier">
                <section>
                    <h2>Identité</h2>
                    <dl>
                        <dt>Nom</dt>
                        <dd>
                            <input type="text" name="nom" />
                        </dd>
                        <dt>Prénom</dt>
                        <dd>
                            <input type="text" name="prenom" />
                        </dd>
                    </dl>
                </section>
                <section>
                    <h2>Informations professionnelles</h2>
                    <dl>
                        <dt>Statut</dt>
                        <dd>
                            <select name="statut">
                                <option value="">Choisir une option</option>
                                <c:forEach var="statut" items="${statuts}">
                                    <option value="${statut[0]}">${statut[1]}</option>
                                </c:forEach>
                            </select>
                        </dd>
                        <dt>Type de personnel</dt>
                        <dd>
                            <select name="personnel">
                                <option value="">Choisir une option</option>
                                <c:forEach var="personnel" items="${personnels}">
                                    <option value="${personnel[0]}">${personnel[1]}</option>
                                </c:forEach>
                            </select>
                        </dd>
                        <dt>Grade</dt>
                        <dd>
                            <select name="grade">
                                <option value="">Choisir une option</option>
                                <c:forEach var="grade" items="${grades}">
                                    <option value="${grade[0]}">${grade[1]}</option>
                                </c:forEach>
                            </select>
                        </dd>
                    </dl>
                </section>
                <section>
                    <h2>Coordonnées</h2>
                    <dl>
                        <dt>Adresse mail</dt>
                        <dd>
                            <input type="text" name="mail" placeholder="Adresse mail" />
                        </dd>
                        <dt>Adresse postale</dt>
                        <dd>
                            <input type="text" name="adresse" placeholder="Adresse postale" />
                        </dd>
                        <dt>Code postal</dt>
                        <dd>
                            <input type="text" name="cp" placeholder="Code postale">
                        </dd>
                        <dt>Ville</dt>
                        <dd>
                            <input type="text" name="ville" placeholder="Ville">
                        </dd>
                    </dl>
                </section>
                <div class="btn-groupe">
                    <input class="a-btn" type="submit" value="Valider" />
                </div>
            </form>
        </main>
        <%@include file="jspf/footer.jspf" %>
    </body>
</html>