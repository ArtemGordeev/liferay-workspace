<%@ page import="com.liferay.portal.kernel.exception.PortalException" %>
<%@ page import="com.liferay.portal.kernel.model.Organization" %>
<%@ page import="com.liferay.portal.kernel.model.PhoneModel" %>
<%@ page import="java.text.SimpleDateFormat" %>
<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/init.jsp" %>

<liferay-ui:search-container searchContainer="${userSearchContainer}">
    <liferay-ui:search-container-results results="${userSearchContainer.getResults() }"/>
    <liferay-ui:search-container-row className="com.liferay.portal.kernel.model.User" modelVar="user"
                                     keyProperty="userId">
        <liferay-ui:search-container-column-text property="userId" name="UserId"/>
        <liferay-ui:search-container-column-text property="fullName" name="ФИО"/>
        <liferay-ui:search-container-column-text property="emailAddress" name="E-mail"/>
        <liferay-ui:search-container-column-text property="jobTitle" name="Должность"/>
        <% SimpleDateFormat sdf = new SimpleDateFormat("dd MMMM yyyy г."); %>
        <liferay-ui:search-container-column-text name="День рождения" value="<%= sdf.format(user.getBirthday()) %>"/>
        <% String phoneNumbers = user.getPhones().stream().map(PhoneModel::getNumber).reduce("", (s1, s2) -> s1 + "<br>" + s2);
            phoneNumbers = phoneNumbers.isEmpty() ? phoneNumbers : phoneNumbers.substring(4);
            String organizations = "";
            try {
                organizations = user.getOrganizations().stream().map(Organization::getName).reduce("", (s1, s2) -> s1 + "<br>" + s2);
            } catch (PortalException e) {
                e.printStackTrace();
            }
            organizations = organizations.isEmpty() ? organizations : organizations.substring(4);
        %>
        <liferay-ui:search-container-column-text name="Телефон" value="<%= phoneNumbers %>"/>
        <liferay-ui:search-container-column-text name="Организация" value="<%= organizations %>"/>
    </liferay-ui:search-container-row>
    <liferay-ui:search-iterator/>
</liferay-ui:search-container>