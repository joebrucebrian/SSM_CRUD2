import com.lty.bean.Admin;
import com.lty.bean.Department;
import com.lty.bean.Employee;
import com.lty.dao.AdminMapper;
import com.lty.dao.DepartmentMapper;
import com.lty.dao.EmployeeMapper;
import com.lty.utils.FunctionUtils;
import org.apache.ibatis.session.SqlSession;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import java.util.UUID;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration(locations = {"classpath:applicationContext.xml"})
public class testMapper {
    @Autowired
    AdminMapper adminMapper;
    @Autowired
    EmployeeMapper employeeMapper;
    @Autowired
    DepartmentMapper departmentMapper;
    @Autowired
    SqlSession sqlSession;

    @Test
    public void testCRUD(){
        adminMapper.insertSelective(new Admin(null,"admin", FunctionUtils.md5Encrypt("123456")));
        adminMapper.insertSelective(new Admin(null,"admin1",FunctionUtils.md5Encrypt("123456")));
        adminMapper.insertSelective(new Admin(null,"admin2",FunctionUtils.md5Encrypt("123456")));
        System.out.println(FunctionUtils.md5Encrypt("123456"));
//        System.out.println(adminMapper.selectByName("admin"));

//        Admin admin = adminMapper.selectByPrimaryKey(1);
//        System.out.println(admin);

//        departmentMapper.insertSelective(new Department(null,"开发部"));
//        departmentMapper.insertSelective(new Department(null,"测试部"));
//        departmentMapper.insertSelective(new Department(null,"市场部"));

//        EmployeeMapper mapper = sqlSession.getMapper(EmployeeMapper.class);
//        for (int i = 0; i < 500; i++) {
//            String uuid = UUID.randomUUID().toString().substring(0,5) + i;
//            mapper.insertSelective(new Employee(null,uuid,"M",uuid+"@sina.com",1));
//        }

//        System.out.println(employeeMapper.selectByPrimaryKeyWithDept(1));

    }
}
