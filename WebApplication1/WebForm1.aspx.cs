using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Script.Serialization;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace WebApplication1
{
    public partial class WebForm1 : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            var js = new JavaScriptSerializer();
            hdnData.Value = js.Serialize(AllData());
            if (!IsPostBack)
            {
                DropDownList1.DataValueField = "Id";
                DropDownList1.DataTextField = "Name";
                DropDownList1.DataSource = AllData();
                DropDownList1.DataBind();
                DropDownList1.Items.Insert(0, new ListItem("Select name", "0"));

            }
        }

        public Dictionary<int, string> GetBcackgroundColor()
        {
            return new Dictionary<int, string>
            {
                 {1,"hotpink"},
                {2,"orchid"},
                {3,"cornflowerblue"}
            };
        }

        public List<Data> AllData()
        {
            var data = new List<Data>
            {
                new Data
                {
                    Id = 1,
                    Name = "Rakesh",
                    Order = 50
                },
                 new Data
                {
                    Id = 2,
                    Name = "Ritesh",
                    Order = 40
                },
                 new Data
                {
                    Id = 3,
                    Name = "Rupesh",
                    Order = 30
                }
            };
            return data;
        }

        public Data DataById(string name)
        {
            var allData = AllData();
            var data = allData.SingleOrDefault(c => c.Name == name);
            return data;
        }
        protected void DropDownList1_SelectedIndexChanged(object sender, EventArgs e)
        {
            var data = DataById(DropDownList1.SelectedItem.Text);
            var js = new JavaScriptSerializer();
            var jsonData = js.Serialize(data);
            hdnSingleData.Value = jsonData;
        }
    }

 
    public class Data
    {
        public int Id { get; set; }
        public string Name { get; set; }
        public int Order { get; set; }
        public string BackgroundColor { get; set; }
    }
}