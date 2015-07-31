package myTools;

import java.util.HashMap;
import java.util.Set;

import com.cloopen.rest.sdk.CCPRestSDK;
import com.cloopen.rest.sdk.CCPRestSDK.BodyType;

public class SDKTestVoiceVerify {

	/**
	 * @param args
	 */
	public static void sendSMS(String phone,String content){
		HashMap<String, Object> result = null;

		CCPRestSDK restAPI = new CCPRestSDK();
		restAPI.init("app.cloopen.com", "8883"); 
		//restAPI.init("sandboxapp.cloopen.com", "8883");// 初始化服务器地址和端口，格式如下，服务器地址不需要写https://
		//restAPI.setAccount("accountSid", "accountToken");// 初始化主帐号和主帐号TOKEN
		restAPI.setAccount("aaf98f894d9e9c40014d9f1fbadc00f2", "b16b50cec3544218a425212abdb0a4e4");
		//restAPI.setAppId("AppId");// 初始化应用ID
		restAPI.setAppId("aaf98f894e8a784b014e91cadccd0aee");
		//result = restAPI.voiceVerify("验证码内容", "号码","显示的号码","3(播放次数)","状态通知回调地址", "语言类型", "第三方私有数据","","");
		result = restAPI.voiceVerify(content, phone,"显示的号码","3","状态通知回调地址", "语言类型", "第三方私有数据");

		System.out.println("SDKTestVoiceVerify result=" + result);
		if("000000".equals(result.get("statusCode"))){
			//正常返回输出data包体信息（map）
			HashMap<String,Object> data = (HashMap<String, Object>) result.get("data");
			Set<String> keySet = data.keySet();
			for(String key:keySet){
				Object object = data.get(key);
				System.out.println(key +" = "+object);
			}
		}else{
			//异常返回输出错误码和错误信息
			System.out.println("错误码=" + result.get("statusCode") +" 错误信息= "+result.get("statusMsg"));
		}
	}

}
