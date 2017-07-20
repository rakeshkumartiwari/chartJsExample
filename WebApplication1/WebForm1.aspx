<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="WebForm1.aspx.cs" Inherits="WebApplication1.WebForm1" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/Chart.js/2.6.0/Chart.min.js"></script>
    <script src="Scripts/jquery-3.1.1.min.js"></script>
    <script src="Scripts/chartLabel.js"></script>
</head>
<body>
    <form id="form1" runat="server">

        <div>
            <asp:DropDownList ID="DropDownList1" runat="server" AutoPostBack="True" OnSelectedIndexChanged="DropDownList1_SelectedIndexChanged">
            </asp:DropDownList>
        </div>

        <div style="height: 400px; width: 400px">
            <canvas width="800" height="450" id="pi-chart-Customers"></canvas>
            <canvas width="800" height="450" id="bar-chart-status"></canvas>
        </div>
        
        <asp:HiddenField ID="hdnCustomers" runat="server" />
        <asp:HiddenField ID="hdnSingleCustomer" runat="server" />
        <asp:HiddenField ID="hdnAllStatus" runat="server" />
        <asp:HiddenField ID="hdnStatus" runat="server" />
    </form>


    <script>
        $(function () {
            
            var strCustomers = $("#hdnCustomers").val();
            var strSingleCustomer = $("#hdnSingleCustomer").val();
            var strAllStatus = $("#hdnAllStatus").val();
            var strStatus = $("#hdnStatus").val();

            if (strStatus == "" || strStatus == "null") {
                barChartForAllStatus(strAllStatus);
            } else {
                barChartForStatus(strStatus);
            }
           
           
            if (strSingleCustomer == "" || strSingleCustomer == "null") {
                pieForAllCustomers(strCustomers);
            } else {
                pieForSingleCustomer(strSingleCustomer);
            }

            function pieForAllCustomers(strCustomers) {

                var jsonCustomers = JSON.parse(strCustomers);
                var labels = [];
                var jobOrders = [];
                var backgroundColor = [];
                $.each(jsonCustomers, function (index, data) {
                    labels.push(data.Name);
                    jobOrders.push(data.JobOrders);
                    backgroundColor.push(getRandomColor());
                });

                var pieOptionsForAllCustomers = {
                    type: 'pie',
                    data: {
                        labels: labels,
                        datasets: [
                            {
                                label: jobOrders,
                                backgroundColor: backgroundColor,
                                data: jobOrders,
                            }
                        ]
                    },
                    options: {
                        title: {
                            display: true,
                            text: 'All Clients'
                        },
                        //legend: {
                        //    display: false
                        //},
                        pieceLabel: {
                            mode: 'value'
                        }
                    }
                };
                var ctx = $("#pi-chart-Customers");
                new Chart(ctx, pieOptionsForAllCustomers);
            }

            function pieForSingleCustomer(strSingleCustomer) {

                var jsonSingleCustomer = JSON.parse(strSingleCustomer);
                var pieOptionForSingleCustomer = {
                    type: 'pie',
                    data: {
                        labels: [jsonSingleCustomer.Name],
                        datasets: [
                            {
                                label: [jsonSingleCustomer.JobOrders],
                                backgroundColor: getRandomColor(),
                                data: [jsonSingleCustomer.JobOrders],
                            }
                        ]
                    },
                    options: {
                        title: {
                            display: true,
                            text: 'Client'
                        },
                        //legend: {
                        //    display: false
                        //},
                        pieceLabel: {
                            mode: 'value'
                        }
                    }
                };
                var ctx = $("#pi-chart-Customers");
                new Chart(ctx, pieOptionForSingleCustomer);
            }
            //----------------------------------------------------------------------------
            //bar chart..


            function barChartForAllStatus(strAllStatus) {

                var jsAllStatus = JSON.parse(strAllStatus);
                var joborders = [];
                var statusLabels = [];
                var backgroundColor = [];
                $.each(jsAllStatus,function(index, data) {
                    joborders.push(data.JobOrders);
                    backgroundColor.push(getRandomColor());

                    switch (data.StatusName) {
                        case 1:
                            statusLabels.push("Created");
                            break;
                        case 2:
                            statusLabels.push("Initiated");
                            break;
                        case 3:
                            statusLabels.push("In Progress");
                            break;
                    default:
                    }
                });
                var barOptionsForStatus = {
                    type: 'bar',
                    data: {
                        labels: statusLabels,
                        datasets: [
                          {
                              label: "Status",
                              backgroundColor: backgroundColor,
                              data: joborders
                          }
                        ]
                    },
                    options: {
                        legend: { display: false },
                        title: {
                            display: true,
                            text: 'All Status'
                        }
                    }
                };
                var ctx = $("#bar-chart-status");
                new Chart(ctx, barOptionsForStatus);
            }
            function barChartForStatus(strStatus) {

                var jsStatus = JSON.parse(strStatus);
                var statusName="";
                switch (jsStatus.StatusName) {
                    case 1:
                        statusName="Created";
                        break;
                    case 2:
                        statusName="Initiated";
                        break;
                    case 3:
                        statusName="In Progress";
                        break;
                    default:
                }
                var barOptionsForStatus = {
                    type: 'bar',
                    data: {
                        labels: [statusName],
                        datasets: [
                          {
                              label: "Status",
                              backgroundColor: getRandomColor(),
                              data: [jsStatus.JobOrders]
                          }
                        ]
                    },
                    options: {
                        legend: { display: false },
                        title: {
                            display: true,
                            text: 'All Status'
                        }
                    }
                };
                var ctx = $("#bar-chart-status");
                new Chart(ctx, barOptionsForStatus);
            }




            function getRandomColor() {
                var letters = '0123456789ABCDEF';
                var color = '#';
                for (var i = 0; i < 6; i++) {
                    color += letters[Math.floor(Math.random() * 16)];
                }
                return color;
            }

        });
    </script>
</body>
</html>
