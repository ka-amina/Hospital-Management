<%--
  Created by IntelliJ IDEA.
  User: Youcode
  Date: 10/15/2025
  Time: 1:47 AM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<jsp:include page="/WEB-INF/template/header.jsp"/>
<h2><c:out value="${empty dto.id?'Nouveau':'Modifier'}"/> docteur</h2>
<c:if test="${not empty error}">
    <div class="alert alert-danger">${error}</div>
</c:if>
<form method="post">
    <input type="hidden" name="id" value="${dto.id}">
    <div class="mb-3">
        <label>Nom</label>
        <input class="form-control" name="nom" value="${dto.nom}" required>
    </div>
    <div class="mb-3">
        <label>Email</label>
        <input type="email" class="form-control" name="email" value="${dto.email}" required>
    </div>
    <div class="mb-3">
        <label>Matricule</label>
        <input class="form-control" name="matricule" value="${dto.matricule}" required>
    </div>
    <div class="mb-3">
        <label>Titre</label>
        <input class="form-control" name="titre" value="${dto.titre}">
    </div>
    <div class="mb-3">
        <label>Spécialité</label>
        <select class="form-select" name="specialtyId" required>
            <c:forEach items="${specialities}" var="s">
                <option value="${s.id}" ${dto.specialtyId eq s.id?'selected':''}>${s.nom}</option>
            </c:forEach>
        </select>
    </div>
    <div class="mb-3 form-check">
        <input type="checkbox" class="form-check-input" name="actif" id="actif" ${dto.actif?'checked':''}>
        <label class="form-check-label" for="actif">Actif</label>
    </div>
    <button type="submit" class="btn btn-primary">Enregistrer</button>
    <a class="btn btn-secondary" href="${pageContext.request.contextPath}/admin/doctors">Annuler</a>
</form>
<jsp:include page="/WEB-INF/template/footer.jsp"/>