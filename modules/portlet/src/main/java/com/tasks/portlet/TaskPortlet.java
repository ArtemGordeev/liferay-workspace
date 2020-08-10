package com.tasks.portlet;

import com.liferay.portal.kernel.dao.orm.QueryUtil;
import com.liferay.portal.kernel.dao.search.SearchContainer;
import com.liferay.portal.kernel.model.User;
import com.liferay.portal.kernel.portlet.bridges.mvc.MVCPortlet;
import com.liferay.portal.kernel.service.UserLocalServiceUtil;
import com.tasks.constants.TaskPortletKeys;
import org.osgi.service.component.annotations.Component;

import javax.portlet.*;
import java.io.IOException;
import java.util.List;

/**
 * @author artem
 */
@Component(
        immediate = true,
        property = {
                "com.liferay.portlet.display-category=category.sample",
                "com.liferay.portlet.header-portlet-css=/css/main.css",
                "com.liferay.portlet.instanceable=true",
                "javax.portlet.display-name=Task",
                "javax.portlet.init-param.template-path=/",
                "javax.portlet.init-param.view-template=/view.jsp",
                "javax.portlet.name=" + TaskPortletKeys.TASK,
                "javax.portlet.resource-bundle=content.Language",
                "javax.portlet.security-role-ref=power-user,user"
        },
        service = Portlet.class
)
public class TaskPortlet extends MVCPortlet {

    @Override
    public void render(RenderRequest request, RenderResponse response)
            throws IOException, PortletException {
        List<User> userList = UserLocalServiceUtil.getUsers(QueryUtil.ALL_POS, QueryUtil.ALL_POS);
        PortletURL iteratorURL = response.createRenderURL();
        SearchContainer<User> searchContainer = new SearchContainer<>(
                request, null, null, SearchContainer.DEFAULT_CUR_PARAM,
                SearchContainer.DEFAULT_DELTA, iteratorURL, null, "");
        searchContainer.setResults(userList);
        request.setAttribute("userSearchContainer", searchContainer);
        super.render(request, response);
    }
}