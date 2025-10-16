<%--
  Created by IntelliJ IDEA.
  User: Youcode
  Date: 10/15/2025
  Time: 1:44 AM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<jsp:include page="/WEB-INF/template/header.jsp"/>
<h2>Gérer les disponibilités</h2>
<c:if test="${param.msg eq 'added'}">
    <div class="alert alert-success">Créneau ajouté</div>
</c:if>
<c:if test="${param.msg eq 'deleted'}">
    <div class="alert alert-warning">Créneau supprimé</div>
</c:if>
<c:if test="${not empty sessionScope.error}">
    <div class="alert alert-danger">${sessionScope.error}</div>
    <c:remove var="error" scope="session"/>
</c:if>

<h4>Créneaux actuels</h4>
<table class="table table-sm table-striped">
    <thead>
    <tr>
        <th>Jour</th>
        <th>Début</th>
        <th>Fin</th>
        <th></th>
    </tr>
    </thead>
    <tbody>
    <c:forEach items="${slots}" var="s">
        <tr>
            <td>${s.jourSemaine}</td>
            <td>${s.heureDebut}</td>
            <td>${s.heureFin}</td>
            <td>
                <form method="post" action="${pageContext.request.contextPath}/admin/availability"
                      onsubmit="return confirm('Supprimer ?');">
                    <input type="hidden" name="_method" value="delete">
                    <input type="hidden" name="slotId" value="${s.id}">
                    <input type="hidden" name="doctorId" value="${param.doctorId}">
                    <button class="btn btn-outline-danger btn-sm">Supprimer</button>
                </form>
            </td>
        </tr>
    </c:forEach>
    </tbody>
</table>

<hr>
<h4>Ajouter un créneau</h4>
<form method="post" action="${pageContext.request.contextPath}/admin/availability">
    <input type="hidden" name="doctorId" value="${param.doctorId}">
    <div class="row g-3">
        <div class="col-auto">
            <label>Jour</label>
            <select class="form-select" name="jour" required>
                <c:forEach var="j" items="MONDAY,TUESDAY,WEDNESDAY,THURSDAY,FRIDAY">
                    <option value="${j}">${j}</option>
                </c:forEach>
            </select>
        </div>
        <div class="col-auto">
            <label>Début</label>
            <input type="time" class="form-control" name="debut" required>
        </div>
        <div class="col-auto">
            <label>Fin</label>
            <input type="time" class="form-control" name="fin" required>
        </div>
        <div class="col-auto align-self-end">
            <button class="btn btn-primary">Ajouter</button>
        </div>
    </div>
</form>
<jsp:include page="/WEB-INF/template/footer.jsp"/>
