package ntou.cs.springboot.config;

import java.io.ByteArrayOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.nio.charset.StandardCharsets;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.http.MediaType;
import org.springframework.security.authentication.UsernamePasswordAuthenticationToken;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.AuthenticationException;
import org.springframework.security.web.authentication.UsernamePasswordAuthenticationFilter;

import com.fasterxml.jackson.databind.ObjectMapper;

public class LoginAuthenticationFilter extends UsernamePasswordAuthenticationFilter {
		@Override
	     public Authentication attemptAuthentication(HttpServletRequest request, HttpServletResponse response) throws AuthenticationException {
			
//			if(request.getContentType()==null)
//	        	System.out.println("sssnull");
//	        else {
//	        	System.out.println(request.getContentType());
//	        	System.out.println(MediaType.APPLICATION_JSON_UTF8_VALUE);
//	        }
			if (request.getContentType().equals(MediaType.APPLICATION_JSON_UTF8_VALUE) ||
	                 request.getContentType().equals(MediaType.APPLICATION_JSON_VALUE)) {
	             ObjectMapper mapper = new ObjectMapper();
	             UsernamePasswordAuthenticationToken authRequest = null;
//	             System.out.println("之前沒問題1");
	             
	             try (InputStream stream = request.getInputStream()) {
//	            	 System.out.println("之前沒問題2");
	            	 
//	            	 ByteArrayOutputStream result = new ByteArrayOutputStream();
//	                 byte[] buffer = new byte[1024];
//	                 int length;
//	                 while ((length = stream.read(buffer)) != -1) {
//	                     result.write(buffer, 0, length);
//	                 }
//	                 System.out.println(result.toString(StandardCharsets.UTF_8.name()));


	                 
	                 Map<String, Object> body = mapper.readValue(stream, Map.class);
	                
	                 
//	                 System.out.println("之前沒問題3");
	                 authRequest = new UsernamePasswordAuthenticationToken(
	                         body.get("account"), body.get("password")
	                 );
//	                 System.out.println("之前沒問題4");
	             } catch (IOException e) {
	                 e.printStackTrace();
	                 authRequest = new UsernamePasswordAuthenticationToken("", "");
	             } finally {
	                 setDetails(request, authRequest);
	                 return this.getAuthenticationManager().authenticate(authRequest);
	             }
	         }
	         else {
	             return super.attemptAuthentication(request, response);
	         }
	     }
	 }