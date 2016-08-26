<%@ Page Language="VB" Trace="True" Debug="True" MasterPageFile="~/PPI/PPI.master" StylesheetTheme="Admin" AutoEventWireup="false" CodeFile="BillingTotal.aspx.vb" Inherits="PPI_Billing" title="Untitled Page" %>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">

<div class="Section">Obtain Billing Data</div>
<asp:Label runat=server ID=myID Visible=False></asp:Label>
<table>
<tr>
<td><b>Month</b></td>
<td>
<asp:DropDownList runat=server ID=MM>
<asp:ListItem Value=1 Text="Jan"></asp:ListItem>
<asp:ListItem Value=2 Text="Feb"></asp:ListItem>
<asp:ListItem Value=3 Text="Mar"></asp:ListItem>
<asp:ListItem Value=4 Text="Apr"></asp:ListItem>
<asp:ListItem Value=5 Text="May"></asp:ListItem>
<asp:ListItem Value=6 Text="Jun"></asp:ListItem>
<asp:ListItem Value=7 Text="Jul"></asp:ListItem>
<asp:ListItem Value=8 Text="Aug"></asp:ListItem>
<asp:ListItem Value=9 Text="Sep" Selected=True></asp:ListItem>
<asp:ListItem Value=10 Text="Oct"></asp:ListItem>
<asp:ListItem Value=11 Text="Nov"></asp:ListItem>
<asp:ListItem Value=12 Text="Dec"></asp:ListItem>
</asp:DropDownList>

<asp:DropDownList runat=server ID=YY>

</asp:DropDownList>
</td>
</tr>

<tr>
<td></td>
<td>
<asp:Button runat=server ID=btnSubmit Text="Get Data" />
</td>
</tr>
</table>
    <asp:SqlDataSource ID="rsData" runat="server" ConnectionString="<%$ ConnectionStrings:cMain %>"
        SelectCommand="SELECT [Office], LastWriteTime, [ProjectRefNo], [AssignmentName], [AssignmentType], [FirstName], [LastName], [DateEntered], [HoganUserName], [OfficeID], [FileName], [ReportTypeName] FROM [qryBilling] order by ReportTypeName, LastWriteTime">
    </asp:SqlDataSource>

<asp:GridView runat=server ID=tabData DataSourceID=rsData ShowFooter=False CellPadding=5 CellSpacing=0 FooterStyle-CssClass="footrow" 
AutoGenerateColumns=False EmptyDataText="No data." HeaderStyle-CssClass=headrow OnRowDataBound="tabData_DataBound">
<Columns>
<asp:BoundField DataField=ProjectRefNo HeaderText="ProjectRefNo" />
<asp:BoundField DataField=AssignmentName HeaderText="Assign. Name" />
<asp:BoundField DataField=AssignmentType HeaderText="Assgn. Type" />
<asp:BoundField DataField=LastName HeaderText="Can. Last Name" />
<asp:BoundField DataField=FirstName HeaderText="Can. First Name" />
<asp:BoundField DataField=HoganUserName HeaderText="Hogan User Name" />
<asp:BoundField DataField=ReportTypeName HeaderText="Report Type" />
<asp:BoundField DataField=LastWriteTime HeaderText="Report Date" DataFormatString="{0:d}" HtmlEncode=False />
</Columns>
</asp:GridView>





</asp:Content>

