<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<jsp:include page="/WEB-INF/template/header.jsp" />

<div class="container">
    <h2>Create Appointment</h2>

    <c:if test="${not empty error}">
        <div class="alert alert-danger">${error}</div>
    </c:if>

    <form method="post" action="${pageContext.request.contextPath}/admin/appointments/new">
        <div class="form-group">
            <label for="patientId">Patient</label>
            <select id="patientId" name="patientId" class="form-control">
                <c:forEach var="p" items="${patients}">
                    <option value="${p.id}">${p.nom} (${p.email})</option>
                </c:forEach>
            </select>
        </div>

        <div class="form-group">
            <label for="doctorId">Doctor</label>
            <select id="doctorId" name="doctorId" class="form-control">
                <c:forEach var="d" items="${doctors}">
                    <option value="${d.id}">${d.nom} - ${d.specialtyName}</option>
                </c:forEach>
            </select>
        </div>

        <div class="form-group">
            <label for="dateRdv">Date</label>
            <input type="date" id="dateRdv" name="dateRdv" class="form-control" required />
        </div>

        <div class="form-group">
            <label for="heureRdv">Time</label>
            <input type="time" id="heureRdv" name="heureRdv" class="form-control" required />
        </div>

        <div class="form-group">
            <label for="type">Type</label>
            <select id="type" name="type" class="form-control">
                <option value="CONSULTATION">CONSULTATION</option>
                <option value="FOLLOW_UP">FOLLOW_UP</option>
                <option value="URGENT">URGENT</option>
                <option value="ROUTINE_CHECKUP">ROUTINE_CHECKUP</option>
            </select>
        </div>

        <div class="form-group">
            <label for="motif">Motif</label>
            <textarea id="motif" name="motif" class="form-control"></textarea>
        </div>

        <div class="form-group">
            <label for="dureeMinutes">Duration (minutes)</label>
            <input type="number" id="dureeMinutes" name="dureeMinutes" value="30" class="form-control" />
        </div>

        <button type="submit" class="btn btn-primary">Create</button>
    </form>
</div>

<jsp:include page="/WEB-INF/template/footer.jsp" />
