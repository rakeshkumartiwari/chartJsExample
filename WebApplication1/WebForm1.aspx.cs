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
            hdnAllStatus.Value = string.Empty;
            hdnCustomers.Value = string.Empty;
            var js = new JavaScriptSerializer();
            var allStatus = GetAllStatus();
            hdnAllStatus.Value = js.Serialize(allStatus);
            var allCustomers = GetAllCustomers();
            hdnCustomers.Value = js.Serialize(allCustomers);
            if (!IsPostBack)
            {
                DropDownList1.DataValueField = "CustomerId";
                DropDownList1.DataTextField = "Name";
                DropDownList1.DataSource = GetAllCustomers();
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

        public List<Customers> GetAllCustomers()
        {
            var customers = new List<Customers>
            {
                new Customers
                {
                    CustomerId = 123,
                    Name = "Rakesh",
                    JobOrders = 3
                },
                 new Customers
                {
                    CustomerId = 456,
                    Name = "Ritesh",
                    JobOrders = 3
                },
                 new Customers
                {
                    CustomerId = 789,
                    Name = "Rupesh",
                    JobOrders = 1
                }
            };
            return customers;
        }

        public Customers GetCustomerById(int customerId)
        {
            var allCustomers = GetAllCustomers();
            var customer = allCustomers.SingleOrDefault(c => c.CustomerId == customerId);
            return customer;
        }

        public List<Status> GetAllStatus()
        {
            var allSatatus = new List<Status>
            {
                new Status
                {
                    CustomerId = 123,
                    JobOrders = 3,
                    StatusName = 1
                },
                new Status
                {
                    CustomerId = 456,
                    JobOrders = 3,
                    StatusName = 2
                },
                new Status
                {
                    CustomerId = 789,
                    JobOrders = 1,
                    StatusName = 3
                },
            };
            return allSatatus;
        }

        public Status GetStatusByCustomerId(int customerId)
        {
            var allStatus = GetAllStatus();
            var status = allStatus.SingleOrDefault(s => s.CustomerId == customerId);
            return status;
        }
        protected void DropDownList1_SelectedIndexChanged(object sender, EventArgs e)
        {
            hdnSingleCustomer.Value = string.Empty;
            var js = new JavaScriptSerializer();
            int selectedCustomer = Convert.ToInt32(DropDownList1.SelectedValue);
            var customer = GetCustomerById(selectedCustomer);

            var status = GetStatusByCustomerId(selectedCustomer);
            hdnStatus.Value = js.Serialize(status);
            var jsonCustomer = js.Serialize(customer);
            hdnSingleCustomer.Value = jsonCustomer;


        }
    }


    public class Customers
    {
        public int CustomerId { get; set; }
        public string Name { get; set; }
        public int JobOrders { get; set; }
        public string BackgroundColor { get; set; }
    }

    public class Status
    {
        public int CustomerId { get; set; }
        public int JobOrders { get; set; }
        public int StatusName { get; set; }
        public string BackgroundColor { get; set; }
    }

}