package myTools;

import java.io.*;

public class fileUtil {
	
	public static void NewFile(String pathString) {
	    File file = new File(pathString);
	    if (!file.exists()) {
	        try {
	            if (file.createNewFile()) {
	                System.out.println("文件创建成功");
	            }
	        } catch (Exception e) {
	            // TODO: handle exception
	            e.printStackTrace();
	        }
	    } else {
	        System.out.println("文件已存在");
	    }
	}
	public static void NewFileBox(String pathString) {
	    File file2 = new File(pathString);
	    if (!file2.exists()) {
	        if (file2.mkdirs()) {
	            System.out.println("文件夹成功");
	        }
	    } else {
	        System.out.println("文件夹存在");
	        file2.delete();//销毁文件
	    }
	}
	public  static void ForFileWriter(String string,String fileName) {
	    File file = new File(fileName);
	    try {
	        FileWriter fWriter = new FileWriter(file);
	        fWriter.write(string);
	        fWriter.close();
	    } catch (Exception e) {
	        // TODO: handle exception
	        e.printStackTrace();
	    }
	}
	public static void ForBufferedWriter(String string,String desFile) {
	    BufferedWriter bWriter = null;
	    try {
	        bWriter = new BufferedWriter(new FileWriter(new File(desFile)));
	        bWriter.write(string.toString());
	        bWriter.close();
	    } catch (Exception e) {
	        e.printStackTrace();
	    }
	}
	/**
	 * 向文件末尾添加新内容
	 * @param string
	 * @param desFile
	 * @throws IOException
	 */
	public static void ForOPSWriter(String string,String desFile) throws IOException{
	
		     File file = new File(desFile);
		     FileOutputStream fos = new FileOutputStream(file,true);
		     OutputStreamWriter osw = new OutputStreamWriter(fos);
		     BufferedWriter bw = new BufferedWriter(osw);
		     bw.write(string);
		     bw.newLine();
		     System.out.println("写入成功");
		     bw.flush();
		     bw.close();
		     osw.close();
		     fos.close();
	}
	
	
	
	public static void testReadByReader(String fileName){
	    File file = new File(fileName);
	    FileReader fis = null;
	    try {
	        fis =  new FileReader(file);
	        char[] arr = new char[1024 * 1000 * 6];
	        int len = fis.read(arr);
	        String data = new String(arr, 0, len);
	        fis.close();
	        System.out.println(fileName+"中按FileReader读取的文件内容是：\n"+data);
	    } catch (Exception e) {
	        // TODO Auto-generated catch block
	        e.printStackTrace();
	    }
	}
	
	public static void testReadByInputStream(String fileName){
	    File file = new File(fileName);
	    FileInputStream fis = null;
	    try {
	        fis =  new FileInputStream(file);
	        byte[] arr = new byte[1024 * 1000 * 6];
	        int len = fis.read(arr);
	        String data = new String(arr, 0, len);
	        fis.close();
	        System.out.println(fileName+"中按FileInputStream读取的文件内容是：\n"+data);
	    } catch (Exception e) {
	        // TODO Auto-generated catch block
	        e.printStackTrace();
	    }
	}
	public static void testReadByBufferedReader(String fileName) {
	    BufferedReader bReader = null;
	    String line = null;
	    StringBuffer buffer = new StringBuffer();
	    try {
	        bReader =new BufferedReader(new FileReader(new File(fileName)));
	        while ((line = bReader.readLine())!=null) {
	            buffer.append(line).append("\n");
	        }
	    } catch (Exception e) {
	        // TODO: handle exception
	        e.printStackTrace();
	    }
	    System.out.println(fileName+"中按BufferedReader读取的文件内容是：\n"+buffer.toString());
	}
	
	/**
	 * 字符流复制
	 * @param readfile
	 * @param writeFile
	 */
	public static void FileCopy1(String readfile,String writeFile) {
	    try {
	        FileReader input = new FileReader(readfile);
	        FileWriter output = new FileWriter(writeFile);
	        int read = input.read();       
	        while ( read != -1 ) {
	            output.write(read);
	            read = input.read();
	        }          
	        input.close();
	        output.close();
	    } catch (IOException e) {
	        System.out.println(e);
	    }
	}
	/**
	 * 字节流复制
	 * @param readfile
	 * @param writeFile
	 */
	public static void FileCopy2(String readfile,String writeFile) {
	    try {
	        FileInputStream input = new FileInputStream(readfile);
	        FileOutputStream output = new FileOutputStream(writeFile);
	        int read = input.read();       
	        while ( read != -1 ) {
	            output.write(read);
	            read = input.read();
	        }          
	        input.close();
	        output.close();
	    } catch (IOException e) {
	        System.out.println(e);
	    }
	}
	/**
	 * 处理流复制
	 * @param readfile
	 * @param writeFile
	 */
	public static void FileCopy3(String readfile,String writeFile) {
	    BufferedReader bReader = null;
	    BufferedWriter bWriter = null;
	    String line = null;
	    try {
	        bReader = new BufferedReader(new FileReader(new File(readfile)));
	        bWriter = new BufferedWriter(new FileWriter(new File(writeFile)));
	        while ((line = bReader.readLine())!=null) {
	            bWriter.write(line);
	            bWriter.newLine();
	        }
	        bWriter.close();
	        bReader.close();
	    } catch (Exception e) {
	        // TODO: handle exception
	        e.printStackTrace();
	    }
	}
}
