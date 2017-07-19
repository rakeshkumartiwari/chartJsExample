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

        <div style="height: 400px;width: 400px">
            <canvas width="800" height="450" id="pi-chart"></canvas>
            <canvas width="800" height="450" id="pi-data"></canvas>
        </div>
        <asp:HiddenField ID="hdnData" runat="server" />
        <asp:HiddenField ID="hdnSingleData" runat="server" />
    </form>


    <script>
        $(function () {
           


            var strData = $("#hdnData").val();
            var jsonData = JSON.parse(strData);
            
            var labels = [];
            var jobOrders = [];
            var backgroundColor = [];
            $.each(jsonData, function (index, data) {
                labels.push(data.Name);
                jobOrders.push(data.Order);
                backgroundColor.push(getRandomColor());
            });
            alert(labels);
            alert(jobOrders);
            var pieOptions = {
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
            var ctx = $("#pi-chart");
            new Chart(ctx, pieOptions);

            var strSingleData = $("#hdnSingleData").val();
            var jsonSingleData = JSON.parse(strSingleData);
            var pieSingleDataOption = {
                type: 'pie',
                data: {
                    labels: [jsonSingleData.Name],
                    datasets: [
                        {
                            label: [jsonSingleData.Order],
                            backgroundColor: getRandomColor(),
                            data: [[jsonSingleData.Order]],
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
            var dataCtx = $("#pi-data");
            new Chart(dataCtx, pieSingleDataOption);

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
