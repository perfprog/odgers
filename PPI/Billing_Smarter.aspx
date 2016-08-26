<%@ Page Language="VB" Trace="false" Debug="false" MasterPageFile="~/PPI/PPI.master"
    StylesheetTheme="Admin" AutoEventWireup="false" CodeFile="Billing_Smarter.aspx.vb"
    Inherits="PPI_Billing" Title="Untitled Page" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <div class="Section">
        Obtain Billing Data</div>
    
    <table>
        <tr>
            <td>
                <b>Month</b>
            </td>
            <td>
                <asp:DropDownList runat="server" ID="MM">
                    <asp:ListItem Value="1" Text="Jan"></asp:ListItem>
                    <asp:ListItem Value="2" Text="Feb"></asp:ListItem>
                    <asp:ListItem Value="3" Text="Mar"></asp:ListItem>
                    <asp:ListItem Value="4" Text="Apr"></asp:ListItem>
                    <asp:ListItem Value="5" Text="May"></asp:ListItem>
                    <asp:ListItem Value="6" Text="Jun"></asp:ListItem>
                    <asp:ListItem Value="7" Text="Jul"></asp:ListItem>
                    <asp:ListItem Value="8" Text="Aug"></asp:ListItem>
                    <asp:ListItem Value="9" Text="Sep"></asp:ListItem>
                    <asp:ListItem Value="10" Text="Oct"></asp:ListItem>
                    <asp:ListItem Value="11" Text="Nov"></asp:ListItem>
                    <asp:ListItem Value="12" Text="Dec"></asp:ListItem>
                </asp:DropDownList>
                <asp:DropDownList runat="server" ID="YY">
                </asp:DropDownList>
                <asp:Button runat=server ID=btnGetData Text="Get Billing Data" ToolTip="shows previously loaded data" />
            </td>
        </tr>
        <tr>
            <td>
            </td>
            <td>
                <asp:Button runat="server" ID="btnSubmit" Text="Scan Folder" ToolTip="use just once" />
            </td>
        </tr>
        <tr>
        <td><b>Total Report Count: </b>
        </td>
        <td><asp:Label runat=server ID=TotalCount Text=0></asp:Label></td></tr>
    </table>
    <asp:SqlDataSource runat="server" ID="rsOffice" ConnectionString="<%$ ConnectionStrings:cMain %>"
        SelectCommand="SELECT [OfficeID], [OfficeName] FROM [Offices] ORDER BY [OfficeName]">
    </asp:SqlDataSource>
    <asp:Repeater runat="server" ID="tabOffice" DataSourceID="rsOffice">
        <ItemTemplate>
            <div class="altrow">
                <asp:Label runat="server" ID="OfficeName" Text='<%# Eval("OfficeName") %>' Font-Bold="True"></asp:Label>
                <asp:Label runat="server" ID="OfficeID" Text='<%# Eval("OfficeID") %>' Visible="False"></asp:Label>
                &nbsp; (Count:
                <asp:Label runat="server" ID="ReportCount" Text="0"></asp:Label>)
            </div>
            <br />
            <asp:GridView runat="server" ID="tabData" ShowFooter="False" CellPadding="5" CellSpacing="0"
                FooterStyle-CssClass="footrow" AutoGenerateColumns="False" EmptyDataText="No data."
                HeaderStyle-CssClass="headrow" OnRowDataBound="tabData_DataBound">
                <Columns>
                    <asp:BoundField DataField="ProjectRefNo" HeaderText="ProjectRefNo" />
                    <asp:BoundField DataField="AssignmentName" HeaderText="Assign. Name" />
                    <asp:BoundField DataField="AssignmentType" HeaderText="Assgn. Type" />
                    <asp:BoundField DataField="LastName" HeaderText="Can. Last Name" />
                    <asp:BoundField DataField="FirstName" HeaderText="Can. First Name" />
                    <asp:BoundField DataField="HoganUserName" HeaderText="Hogan User Name" />
                    <asp:BoundField DataField="ReportTypeName" HeaderText="Report Type" />
                    <asp:BoundField DataField="ClientName" HeaderText="Client Name" />
                    <asp:BoundField DataField="PartnerName" HeaderText="Partner Name" />
                    <asp:BoundField DataField="LastWriteTime" HeaderText="Report Date" DataFormatString="{0:d}"
                        HtmlEncode="False" />
                </Columns>
            </asp:GridView>
            <br />
            <br />
        </ItemTemplate>
    </asp:Repeater>
</asp:Content>
