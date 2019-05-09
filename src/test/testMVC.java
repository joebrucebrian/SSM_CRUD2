import com.github.pagehelper.PageInfo;
import com.lty.bean.Employee;
import org.junit.Before;
import org.junit.Ignore;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.mock.web.MockHttpServletRequest;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;
import org.springframework.test.context.web.WebAppConfiguration;
import org.springframework.test.web.servlet.MockMvc;
import org.springframework.test.web.servlet.MvcResult;
import org.springframework.test.web.servlet.request.MockMvcRequestBuilders;
import org.springframework.test.web.servlet.setup.MockMvcBuilders;
import org.springframework.web.context.WebApplicationContext;

import java.util.List;

/**
 * 使用spring测试模块提供的测试请求功能，测试crud请求的正确性
 * 注意Spring4测试时需要servlet3.0支持
 */
@RunWith(SpringJUnit4ClassRunner.class)
@WebAppConfiguration
@ContextConfiguration(locations = {"classpath:applicationContext.xml","classpath:SpringMVC-servlet.xml"})
public class testMVC {
    //传入SpringMVC的ioc容器
    @Autowired
    WebApplicationContext context;
    //虚拟mvc请求，获取到处理结果
    MockMvc mockMvc;

    @Before
    public void initMockMvc(){
        mockMvc = MockMvcBuilders.webAppContextSetup(context).build();
    }

    @Test
    public void testPage()throws Exception{
        //模拟请求，拿到返回值
        MvcResult result = mockMvc.perform(MockMvcRequestBuilders.get("/emps").param("pn","1")).andReturn();

        //若请求成功，请求域中会有pageInfo
        MockHttpServletRequest request = result.getRequest();
        PageInfo page = (PageInfo) request.getAttribute("pageInfo");
        System.out.println(page);
//        System.out.println("当前页码" + page.getPageNum());
//        System.out.println("总页码" + page.getPages());
//        System.out.println("总记录数" + page.getTotal());
//        System.out.print("连续显示页面:");
//        for (int i : page.getNavigatepageNums()) {
//            System.out.print(" " + i);
//        }
//        //获取员工数据
//        List<Employee> list = page.getList();
//        for (Employee e : list) {
//            System.out.println(e);
//        }
    }

    @Test
    @Ignore
    public void testDept()throws Exception{
        //模拟请求，拿到返回值
        MvcResult result = mockMvc.perform(MockMvcRequestBuilders.get("/depts")).andReturn();
        //若请求成功，请求域中会有pageInfo
        MockHttpServletRequest request = result.getRequest();
        Object o = request.getAttribute("deptList");
//        List<Department> list = (List<Department>)request.getAttribute("deptList");
        System.out.println(o);
    }
}
