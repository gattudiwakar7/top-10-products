import java.io.FileWriter;
import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

import org.jsoup.Jsoup;
import org.jsoup.nodes.Document;
import org.jsoup.nodes.Element;
import org.jsoup.select.Elements;

public class ProductScraper {

    public static void main(String[] args) {

        String url = "https://www.quill.com/hanging-file-folders/cbl/4378.html";
        String base_url = "https://www.quill.com";
        List<Product> productList = new ArrayList<>();

        try {
            Document doc = Jsoup.connect(url).get();
            Elements products = doc.select("div.search-product-card");

            for (Element product : products) {
                String title = product.select("a.inline-link.scTrack.pfm.fg-jet.search-product-name.font-weight-lightbold").text();
                String link = base_url + product.select("a.inline-link.scTrack.pfm.fg-jet.search-product-name.font-weight-lightbold").attr("href");
                String price = product.select("span.price-size.mb-0.text-black").text();
                String desc = product.select("div.sku-bullet-list.pl-3").text();

                Product p = new Product(title, desc, link, price);
                productList.add(p);
            }

            FileWriter csvWriter = new FileWriter("product_details.csv");
            csvWriter.append("Title, Desc, Link, Price\n");

            for (Product product : productList) {
                csvWriter.append(product.getTitle());
                csvWriter.append(",");
                csvWriter.append(product.getDesc());
                csvWriter.append(",");
                csvWriter.append(product.getLink());
                csvWriter.append(",");
                csvWriter.append(product.getPrice());
                csvWriter.append("\n");
            }

            csvWriter.flush();
            csvWriter.close();
            System.out.println("Product details written to CSV file.");

        } catch (IOException e) {
            e.printStackTrace();
        }

    }

}

class Product {

    private String title;
    private String desc;
    private String link;
    private String price;

    public Product(String title, String desc, String link, String price) {
        this.title = title;
        this.desc = desc;
        this.link = link;
        this.price = price;
    }

    // Getters and setters

    public String getTitle() {
        return title;
    }

    public void setTitle(String title) {
        this.title = title;
    }

    public String getDesc() {
        return desc;
    }

    public void setDesc(String desc) {
        this.desc = desc;
    }

    public String getLink() {
        return link;
    }

    public void setLink(String link) {
        this.link = link;
    }

    public String getPrice() {
        return price;
    }

    public void setPrice(String price) {
        this.price = price;
    }

}