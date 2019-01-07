package com.encore.service;

import java.io.IOException;
import java.io.UnsupportedEncodingException;
import java.net.URLEncoder;
import java.util.Arrays;
import java.util.List;
import java.util.concurrent.TimeUnit;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.jsoup.Jsoup;
import org.openqa.selenium.By;
import org.openqa.selenium.Keys;
import org.openqa.selenium.WebDriver;
import org.openqa.selenium.WebElement;
import org.openqa.selenium.chrome.ChromeDriver;
import org.openqa.selenium.chrome.ChromeOptions;

import kr.hyosang.coordinate.CoordPoint;
import kr.hyosang.coordinate.TransCoord;

public class ChromeDriverUtil {
	public static void naver(HttpServletRequest request, HttpServletResponse response) throws InterruptedException {

		System.setProperty("webdriver.chrome.driver", "C:\\Users\\Ara\\utils\\chromedriver_win32\\chromedriver.exe"); // 크롬
		// 경로설정

		ChromeOptions options = new ChromeOptions();
//		options.addArguments("headless");
//		options.addArguments("disable-gpu");

		WebDriver driver = new ChromeDriver(options);
		driver.manage().timeouts().implicitlyWait(5, TimeUnit.SECONDS);

		String[] starts = request.getParameter("start").split(",");
		String[] arrives = request.getParameter("arrive").split(",");

		driver.get("https://map.naver.com/");
		driver.findElement(By.xpath("//*[@id=\"nav\"]/ul/li[2]/a")).click();
		driver.findElement(By.xpath("//*[@id=\"panel\"]/div[2]/div[1]/div[1]/div[1]/ul/li[2]/a")).click();
		List<WebElement> list = driver.findElements(By.cssSelector(".pf_enter .pf_ii>.input_act"));
		list.get(0).sendKeys(starts[0]);
		list.get(0).sendKeys(Keys.ENTER);

		Thread.sleep(1000);

		list.get(1).sendKeys(arrives[0]);
		list.get(1).sendKeys(Keys.ENTER);

		Thread.sleep(1000);

		driver.findElement(By.xpath("//*[@id=\"panel\"]/div[2]/div[1]/div[1]/div[1]/div[2]/a[3]")).click();

		Thread.sleep(1000);

		List<WebElement> elements = driver.findElements(By.cssSelector(
				"#panel > div.panel_content.nano.has-scrollbar > div.scroll_pane.content > div.panel_content_flexible"));
		for (WebElement el : elements) {
			System.out.println(el.getText());
		}

		driver.quit();
	}

	public static void naverDetail(HttpServletRequest request, HttpServletResponse response)
			throws UnsupportedEncodingException, InterruptedException {
		// TODO Auto-generated method stub
		System.setProperty("webdriver.chrome.driver", "C:\\Users\\Ara\\utils\\chromedriver_win32\\chromedriver.exe");

		ChromeOptions options = new ChromeOptions();
		options.addArguments("headless");
		options.addArguments("disable-gpu");
		WebDriver driver = new ChromeDriver(options);
		driver.manage().timeouts().implicitlyWait(5, TimeUnit.SECONDS);

		String[] starts = request.getParameter("start").split(",");
		String[] arrives = request.getParameter("arrive").split(",");
		System.out.println(Arrays.toString(starts));
		System.out.println(Arrays.toString(arrives));

		String url = "https://map.naver.com/findroute2/searchPubtransPath.nhn?apiVersion=3&searchType=0&start="
				+ starts[2] + "%2C" + starts[1] + "%2C" + URLEncoder.encode(starts[0], "UTF-8") + "&destination="
				+ arrives[2] + "%2C" + arrives[1] + "%2C" + URLEncoder.encode(arrives[0], "UTF-8");
		System.out.println(url);
		driver.get(url);

		WebElement element = driver.findElement(By.cssSelector("body > pre"));
		System.out.println(element.getText());
		Thread.sleep(3000);
		driver.quit();
	}

	public static String[] daum() throws InterruptedException, ServletException, IOException {
		System.setProperty("webdriver.chrome.driver", "C:\\Users\\Ara\\utils\\chromedriver_win32\\chromedriver.exe");

		ChromeOptions options = new ChromeOptions();
//		options.addArguments("headless");
//		options.addArguments("disable-gpu");
		WebDriver driver = new ChromeDriver(options);
		driver.manage().timeouts().implicitlyWait(5, TimeUnit.SECONDS);

		String url = "http://map.daum.net/";

		driver.get(url);
		driver.findElement(By.xpath("//*[@id=\"search.tab2\"]/a")).click();
		driver.findElement(By.cssSelector("#info\\2e route\\2e waypointSuggest\\2e input0")).sendKeys("경복궁");
		Thread.sleep(500);
		driver.findElement(By.cssSelector("#info\\2e route\\2e waypointSuggest\\2e input0")).sendKeys(Keys.ENTER);
		Thread.sleep(700);
		driver.findElement(By.cssSelector("#info\\2e route\\2e waypointSuggest\\2e input1")).sendKeys("엔코아");
		Thread.sleep(700);
		driver.findElement(By.cssSelector("#info\\2e route\\2e waypointSuggest\\2e input1")).sendKeys(Keys.ENTER);
		driver.findElement(By.xpath("//*[@id=\"transittab\"]")).click();
		Thread.sleep(700);
		WebElement element = driver.findElement(By.cssSelector("#daum-maps-shape-90"));
		Thread.sleep(1000);
		String[] dlist = element.getAttribute("d").substring(1, element.getAttribute("d").length()).split(" ");
		for (int i = 0; i < dlist.length; i++)
			dlist[i] = dlist[i].substring(0, dlist[i].length() - 1);
		driver.quit();
		return dlist;
	}

	public static void daumWithJsoup(String[] starts, String[] ends) throws InterruptedException, ServletException, IOException {

//		String url = "http://map.search.daum.net/mapsearch/map.daum?callback=jQuery1810040666559908033584_1544805827672&q="
//				+ URLEncoder.encode(starts[0], "utf-8") + "&msFlag=A&sort=0&gb=R";
//		String coords = Jsoup.connect(url).referrer("http://map.daum.net/").userAgent(
//				"Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/70.0.3538.110 Safari/537.36")
//				.ignoreContentType(true).execute().body();

		CoordPoint start = wCongnamul(Double.parseDouble(starts[2]), Double.parseDouble(starts[1]));
		CoordPoint end = wCongnamul(Double.parseDouble(ends[2]), Double.parseDouble(ends[1]));
		
		String url = "http://map.daum.net/route/pubtrans.json?inputCoordSystem=WCONGNAMUL&outputCoordSystem=WCONGNAMUL&service=map.daum.net&callback=jQuery1810027754613450955867_1544801980319&sX=" + start.x + "&sY=" + start.y + "&sName=" + URLEncoder.encode(starts[0], "utf-8") + "&eX=" + end.x + "&eY=" + end.y + "&eName=" + ends[0];
		String doc = Jsoup.connect(url).referrer("http://map.daum.net/").userAgent("Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/70.0.3538.110 Safari/537.36").ignoreContentType(true).execute().body();

		System.out.println(doc == null? "doc is null..." : "doc is not null...");
		System.out.println(doc);
	}
	
	public static String daumWithJsoup2(String[] starts, String[] ends) throws InterruptedException, ServletException, IOException {

//		String url = "http://map.search.daum.net/mapsearch/map.daum?callback=jQuery1810040666559908033584_1544805827672&q="
//				+ URLEncoder.encode(starts[0], "utf-8") + "&msFlag=A&sort=0&gb=R";
//		String coords = Jsoup.connect(url).referrer("http://map.daum.net/").userAgent(
//				"Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/70.0.3538.110 Safari/537.36")
//				.ignoreContentType(true).execute().body();

		CoordPoint start = wCongnamul(Double.parseDouble(starts[2]), Double.parseDouble(starts[1]));
		CoordPoint end = wCongnamul(Double.parseDouble(ends[2]), Double.parseDouble(ends[1]));
		
		String url = "http://map.daum.net/route/pubtrans.json?inputCoordSystem=WCONGNAMUL&outputCoordSystem=WCONGNAMUL&service=map.daum.net&callback=jQuery1810027754613450955867_1544801980319&sX=" + start.x + "&sY=" + start.y + "&sName=" + URLEncoder.encode(starts[0], "utf-8") + "&eX=" + end.x + "&eY=" + end.y + "&eName=" + ends[0];
		String doc = Jsoup.connect(url).referrer("http://map.daum.net/").userAgent("Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/70.0.3538.110 Safari/537.36").ignoreContentType(true).execute().body();

		System.out.println(doc == null? "doc is null..." : "doc is not null...");
		return doc;
	}

	public static CoordPoint wCongnamul(double x, double y) {
		return TransCoord.getTransCoord(new CoordPoint(x, y), TransCoord.COORD_TYPE_WGS84,
				TransCoord.COORD_TYPE_WCONGNAMUL);
	}
}
