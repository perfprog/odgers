<%@ Page Title="Email Reports" Trace="false" Debug="false" Language="VB" MasterPageFile="~/admin.master"
    AutoEventWireup="false" StylesheetTheme="Admin" CodeFile="CEOx1Day.aspx.vb" Inherits="CEOx1Day" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <table>
        <tr>
            <td>
                Last Name:
            </td>
            <td>
                <asp:TextBox runat="server" ID="LastName"></asp:TextBox> (* Leave blank to retrieve all) 
            </td>
        </tr>
        <tr>
            <td>
                Sent/Unsent
            </td>
            <td>
                <asp:DropDownList runat="server" ID="SentStatus">
                    <asp:ListItem Text="Both" Value=""></asp:ListItem>
                    <asp:ListItem Text="Sent" Value="Sent"></asp:ListItem>
                    <asp:ListItem Text="Unsent" Value="Unsent"></asp:ListItem>
                </asp:DropDownList>
            </td>
        </tr>
        <tr>
            <td>
            </td>
            <td>
                <asp:Button runat="server" ID="btnGet" Text="Show Matching Candidates" />
                <br />
                <asp:Label runat="server" ID="Message" EnableViewState="false" CssClass="error"></asp:Label>
            </td>
        </tr>
    </table>
    <asp:GridView runat="server" ID="tabA" CellPadding="4" CellSpacing="0" AutoGenerateColumns="false"
        EmptyDataText="No matching data at this time." HeaderStyle-CssClass="headrow"
        FooterStyle-CssClass="footrow" ShowFooter="true" AlternatingRowStyle-CssClass="altrow">
        <Columns>
            <asp:BoundField DataField="LastName" HeaderText="Last Name" />
            <asp:BoundField DataField="FirstName" HeaderText="First Name" />
            <asp:BoundField DataField="CEOx1day_EmailDate" HeaderText="Date Emailed" />
            <asp:TemplateField HeaderText="Report(s)">
                <ItemTemplate>
                    <asp:Label runat="server" ID="HoganuserName" Text='<%# Eval("HoganUserName") %>'
                        Visible="false"></asp:Label>
                        <asp:Label runat="server" ID="LanguageID" Text='<%# Eval("LanguageID") %>'
                        Visible="false"></asp:Label>
                        <asp:Label runat="server" ID="CandidateID" Text='<%# Eval("CandidateID") %>'
                        Visible="false"></asp:Label>
                        <asp:Label runat="server" ID="EmailAddress" Text='<%# Eval("EmailAddress") %>'
                        Visible="false"></asp:Label>
                        <asp:Label runat="server" ID="AdminEmailAddress" Text='<%# Eval("AdminEmailAddress") %>'
                        Visible="false"></asp:Label>
                </ItemTemplate>
            </asp:TemplateField>
            <asp:TemplateField>
                <HeaderTemplate>
                    <input type="checkbox" onclick="email_set(this);" />
                </HeaderTemplate>
                <ItemTemplate>
                    <asp:CheckBox runat="server" ID="SendEmail" />
                </ItemTemplate>
                <ItemStyle HorizontalAlign="Center" />
                <FooterTemplate>
                    <asp:Button runat="server" ID="btnEmail" Text="Email Reports" CommandName="EmailReports" />
                </FooterTemplate>
            </asp:TemplateField>
        </Columns>
    </asp:GridView>
    <script language="javascript" type="text/javascript">
        function email_set(which) {
            //alert(which.checked);

            f1 = document.forms[0];

            for (var i1 = 0; i1 < f1.elements.length; i1++) {
                e2 = f1.elements[i1];
                sname = (e2.name);
                //alert(sname + ' ' + which);
                if (sname.indexOf("SendEmail") > 0) e2.checked = which.checked;
            }
        }
    </script>
</asp:Content>
