<%@ Page Language="VB" Trace="False" Debug="False" MasterPageFile="Notloggedin.master" AutoEventWireup="false" CodeFile="Default.aspx.vb" Inherits="Index" title="Login" StylesheetTheme="Admin" %>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
&nbsp;<asp:Label ID="Label1" runat="server" Font-Bold="True" Style="position: relative"
        Text="Login" Width="174px"></asp:Label>
    
    <table>
        <tr>
            <td>User Name:
            </td>
            <td>
                <asp:TextBox ID="UserName" runat="server" CssClass="box"></asp:TextBox>
                <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" Text="UserName must be entered" ErrorMessage="RequiredFieldValidator" ControlToValidate="UserName"></asp:RequiredFieldValidator>
            </td>
        </tr>
        <tr>
            <td>Password:
            </td>
            <td>
                <asp:TextBox ID="UserPassword" TextMode="Password" runat="server" CssClass="box"></asp:TextBox>
                <asp:RequiredFieldValidator ID="RequiredFieldValidator2" runat="server" Text="Password must be entered" ErrorMessage="RequiredFieldValidator" ControlToValidate="UserPassword"></asp:RequiredFieldValidator>            
            </td>
        </tr>
        <tr>
            <td>
            </td>
            <td>
                <asp:Button ID="btnLogin" runat="server" Text="Login" CssClass="btn" />
            </td>
        </tr>
        <tr>
            <td>
            </td>
            <td>
                <asp:Label ID="Message" Text="" CssClass="error" runat="server" EnableViewState="false"></asp:Label>
            </td>
        </tr>
    </table>

</asp:Content>

