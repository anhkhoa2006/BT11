package vn.hcmute.config;

import org.sitemesh.builder.SiteMeshFilterBuilder;
import org.sitemesh.config.ConfigurableSiteMeshFilter;

public class SiteMeshFilter_24133031 extends ConfigurableSiteMeshFilter {
    @Override
    protected void applyCustomConfiguration(SiteMeshFilterBuilder builder) {
        // Decorator cho vai trò Admin
        builder.addDecoratorPath("/admin/*", "/decorators/admin.jsp");
        
        // Decorator cho vai trò User
        builder.addDecoratorPath("/*", "/decorators/user.jsp");

        // Loại trừ các tài nguyên tĩnh và các trang popup/ảnh nếu có
        builder.addExcludedPath("/assets/*");
        builder.addExcludedPath("/static/*");
        builder.addExcludedPath("/images/*");
    }
}
