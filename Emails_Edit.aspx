<%@ Page Title="Edit Emails" Trace="false" Debug="false" Language="VB" MasterPageFile="~/admin.master" AutoEventWireup="false"
    ValidateRequest="false" StylesheetTheme="Admin" CodeFile="Emails_Edit.aspx.vb"
    Inherits="Emails_Edit" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <asp:SqlDataSource ID="rsA" runat="server" ConnectionString="<%$ ConnectionStrings:cMain %>"
        SelectCommand="SELECT [LanguageID], [LanguageName], [EmailSubject], [EmailMessage], [EngSubject], [EngMessage] FROM [Lang_Emails] order by LanguageName">
    </asp:SqlDataSource>
    <table>
        <tr>
            <td valign=top>
                <b>Select Language: </b>
            </td>
            <td>
                <asp:DropDownList runat="server" ID="LanguageID" DataSourceID="rsA" DataTextField="LanguageName"
                    DataValueField="LanguageID" AutoPostBack="true">
                </asp:DropDownList>
                <br />
                <asp:Label runat=server ID=Message EnableViewState=false CssClass=error></asp:Label>
            </td>
        </tr>
    </table>
    <asp:Repeater runat="server" ID="tabA" DataSourceID="rsA">
        <ItemTemplate>
            <table cellpadding="3" cellspacing="0" width="800" border="1">
                <tr>
                    <td>
                        <asp:Label runat="server" ID="LanguageID" Visible="false" Text='<%# Eval("LanguageID") %>'></asp:Label>
                        <asp:Label runat="server" ID="EngSubject" Text='<%# Eval("EngSubject") %>'></asp:Label>
                    </td>
                    <td>
                        <asp:TextBox runat="server" ID="EmailSubject" Width="650" Text='<%# Bind("EmailSubject") %>'></asp:TextBox>
                    </td>
                </tr>
                <tr>
                    <td valign="top">
                        <asp:Label runat="server" ID="EngMessage" Text='<%# CF.fshtml(Eval("EngMessage")) %>'></asp:Label>
                    </td>
                    <td valign="top">
                        <asp:TextBox runat="server" ID="EmailMessage" TextMode="MultiLine" Rows="70" Columns="80"
                            Text='<%# Bind("EmailMessage") %>'></asp:TextBox>
                    </td>
                </tr>
                <tr>
                <td></td>
                <td>
                <asp:Button runat=server ID=btnSave Text="Save Changes" CommandName="Update1" />
                <asp:HyperLink runat=server ID=hlView Text="Preview" NavigateUrl='<%# "Emails_view.aspx?LanguageID=" & Eval("LanguageID") %>' Target="view"></asp:HyperLink>
                </td></tr>
            </table>
        </ItemTemplate>
    </asp:Repeater>
    </td> </tr> </table>
</asp:Content>
