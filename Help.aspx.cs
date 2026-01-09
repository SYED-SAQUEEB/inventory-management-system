using System;

public partial class Admin_Help : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
            LoadEnglish();
    }

    protected void btnEN_Click(object sender, EventArgs e)
    {
        LoadEnglish();
    }

    protected void btnMR_Click(object sender, EventArgs e)
    {
        LoadMarathi();
    }

    protected void btnHI_Click(object sender, EventArgs e)
    {
        LoadHindi();
    }

    private void LoadEnglish()
    {
        litHelpContent.Text = @"
<h1>Help Center – Warehouse Inventory Management System</h1>

<p>This system helps you manage products, stock, purchases, customers, and sales efficiently.</p>

<h3>1. Dashboard</h3>
<ul>
<li>View total customers, products, purchases, and sales</li>
<li>Monitor today’s revenue</li>
</ul>

<h3>2. Customers</h3>
<ul>
<li>Add and manage customer details</li>
<li>Store city and contact information</li>
</ul>

<h3>3. Products</h3>
<ul>
<li>Add products with unit, category, and price</li>
<li>Edit or delete product information</li>
</ul>

<h3>4. Purchases</h3>
<ul>
<li>Record stock purchases</li>
<li>Purchases automatically increase stock</li>
</ul>

<h3>5. Sales</h3>
<ul>
<li>Create sales bills</li>
<li>Track payment mode and pending amounts</li>
</ul>

<h3>6. Stock Report</h3>
<ul>
<li>View current available stock</li>
<li>Low stock items are highlighted</li>
</ul>

<h3>Need Support?</h3>
<p>Contact your system administrator or IT support.</p>
";
    }

    private void LoadMarathi()
    {
        litHelpContent.Text = @"
<h1>मदत केंद्र – वेअरहाऊस व्यवस्थापन प्रणाली</h1>

<p>ही प्रणाली उत्पादने, स्टॉक, खरेदी, विक्री व ग्राहक व्यवस्थापनासाठी वापरली जाते.</p>

<h3>डॅशबोर्ड</h3>
<ul>
<li>एकूण ग्राहक, उत्पादने, खरेदी व विक्री पाहा</li>
</ul>

<h3>ग्राहक</h3>
<ul>
<li>ग्राहकांची माहिती नोंदवा</li>
</ul>

<h3>उत्पादने</h3>
<ul>
<li>नवीन उत्पादने जोडा</li>
</ul>

<h3>खरेदी</h3>
<ul>
<li>स्टॉक खरेदी नोंदवा</li>
</ul>

<h3>स्टॉक</h3>
<ul>
<li>उपलब्ध स्टॉक पाहा</li>
</ul>
";
    }

    private void LoadHindi()
    {
        litHelpContent.Text = @"
<h1>सहायता केंद्र – वेयरहाउस प्रबंधन प्रणाली</h1>

<p>यह सिस्टम उत्पाद, स्टॉक, खरीद और बिक्री प्रबंधन के लिए है।</p>

<h3>डैशबोर्ड</h3>
<ul>
<li>कुल ग्राहक और बिक्री देखें</li>
</ul>

<h3>ग्राहक</h3>
<ul>
<li>ग्राहक जानकारी प्रबंधित करें</li>
</ul>

<h3>उत्पाद</h3>
<ul>
<li>उत्पाद जोड़ें और संशोधित करें</li>
</ul>

<h3>खरीद</h3>
<ul>
<li>स्टॉक खरीद दर्ज करें</li>
</ul>

<h3>स्टॉक</h3>
<ul>
<li>वर्तमान स्टॉक स्थिति देखें</li>
</ul>
";
    }
}
