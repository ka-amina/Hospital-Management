<%--
  Created by IntelliJ IDEA.
  User: Youcode
  Date: 10/15/2025
  Time: 1:46 AM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<jsp:include page="/WEB-INF/template/header.jsp"/>
<h2>Liste des docteurs</h2>
<a class="btn btn-primary" href="${pageContext.request.contextPath}/admin/doctors/new">Nouveau docteur</a>
<c:if test="${param.msg eq 'doc-created'}">
    <div class="alert alert-success">Docteur créé</div>
</c:if>
<c:if test="${param.msg eq 'doc-updated'}">
    <div class="alert alert-success">Docteur modifié</div>
</c:if>
<c:if test="${param.msg eq 'doc-deleted'}">
    <div class="alert alert-warning">Docteur désactivé</div>
</c:if>
<table class="table table-striped">
    <thead>
    <tr>
        <th>Matricule</th>
        <th>Nom</th>
        <th>Spécialité</th>
        <th>Département</th>
        <th>Actif</th>
        <th></th>
    </tr>
    </thead>
    <tbody>
    <c:forEach items="${doctors}" var="d">
        <tr>
            <td>${d.matricule}</td>
            <td>${d.nom}</td>
            <td>${d.specialtyName}</td>
            <td>${d.departmentName}</td>
            <td><span class="badge ${d.actif?'bg-success':'bg-secondary'}">${d.actif?'Oui':'Non'}</span></td>
            <td>
                <a class="btn btn-sm btn-outline-primary"
                   href="${pageContext.request.contextPath}/admin/doctors/edit?id=${d.id}">Modifier</a>
                <form style="display:inline" action="${pageContext.request.contextPath}/admin/doctors/delete"
                      method="post">
                    <input type="hidden" name="id" value="${d.id}">
                    <button class="btn btn-sm btn-outline-danger" onclick="return confirm('Supprimer ?')">Supprimer
                    </button>
                </form>
            </td>
        </tr>
    </c:forEach>
    </tbody>
</table>
<jsp:include page="/WEB-INF/template/footer.jsp"/>