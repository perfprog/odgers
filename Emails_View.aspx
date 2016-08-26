<%@ Page Title="Preview Emails" Language="VB" MasterPageFile="~/admin.master" AutoEventWireup="false"
    CodeFile="Emails_View.aspx.vb" Inherits="Emails_View" StylesheetTheme="Admin" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <asp:SqlDataSource ID="rsA" runat="server" ConnectionString="<%$ ConnectionStrings:cMain %>"
        SelectCommand="SELECT [LanguageID], [LanguageName], [EmailSubject], [EmailMessage] FROM [Languages] WHERE ([LanguageID] = @LanguageID)">
        <SelectParameters>
            <asp:QueryStringParameter Name="LanguageID" QueryStringField="LanguageID" DefaultValue="2"
                Type="Byte" />
        </SelectParameters>
    </asp:SqlDataSource>
    <asp:Repeater runat="server" ID="tabA" DataSourceID="rsA">
        <ItemTemplate>
            <table cellpadding="3" cellspacing="0" width="800" border="1">
                <tr>
                    <td>
                        <asp:Label runat="server" ID="LanguageName" Text='<%# Eval("LanguageName") %>' Font-Size="Large"></asp:Label>
                        <br />
                        <br />
                    </td>
                </tr>
                <tr>
                    <td valign="top">
                        <b>Subject:
                            <asp:Label runat="server" ID="EmailSubject" Text='<%# CF.fsHtml(Eval("EmailSubject")) %>'></asp:Label>
                        </b>
                        <br />
                        <br />
                        <asp:Label runat="server" ID="EmailMessage" Text='<%# CF.fsHtml(Eval("EmailMessage")) %>'></asp:Label>
                    </td>
                </tr>
            </table>
        </ItemTemplate>
    </asp:Repeater>
</asp:Content>
