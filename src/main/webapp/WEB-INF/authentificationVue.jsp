<%-- 
    Document   : authentificationVue
    Created on : 6 oct. 2025, 16:35:38
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
            <h1>Authentification</h1>
            <form method="POST" action="authentification" class="login">
                <section>
                <dl>
                    <dt>Nom d'utilisateur</dt>
                    <dd><input name="pseudo" type='text'></label></dd>
                    <dt>Mot de passe</dt>
                    <dd><input name='mdp' type='password'></label>
                </dl>
                <div class='btn-groupe'>
                    <button type="submit">Connexion</button>
                </div>
                
                </section>
            </form>
        </main>
        <%@include file="jspf/footer.jspf" %>
    </body>
</html>
