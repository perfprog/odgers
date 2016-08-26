<%@ Page Title="Assignment Emails" Trace="false" Debug="false" StylesheetTheme="Admin"
    ValidateRequest="false" Language="VB" MasterPageFile="~/admin.master" AutoEventWireup="false"
    CodeFile="Assgn_Email.aspx.vb" Inherits="Assignment_Emails" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <asp:SqlDataSource ID="rsE" runat="server" ConnectionString="<%$ ConnectionStrings:cMain %>"
        SelectCommand="SELECT top 1 AssgnID, EmailSubject, EmailMessage, OfficeID FROM qryAssgn_Email where ((@OfficeID&lt;999 and OfficeID=@OfficeID) or (@OfficeID=999)) and AssgnID=@AssgnID">
        <SelectParameters>
            <asp:CookieParameter CookieName="OfficeID" Name="OfficeID" Type="Int32" />
            <asp:QueryStringParameter Name="AssgnID" QueryStringField="AssgnID" />
        </SelectParameters>
    </asp:SqlDataSource>
    <table>
        <tr>
            <td>
                <b>Current Text</b><asp:Label runat="server" ID="OfficeID" Visible="false"></asp:Label>
                &nbsp; &nbsp; &nbsp; <asp:Label runat="server" ID="Message" EnableViewState="false" CssClass="error"></asp:Label>
            </td>
            <td width="20">
            </td>
            <td>
                <b>Initialize Text using Language template</b>
            </td>
        </tr>
        <tr>
            <td valign="top">
                <asp:Repeater runat="server" ID="tabE" DataSourceID="rsE">
                    <ItemTemplate>
                        <table>
                            <tr>
                                <td valign="top">
                                    Subject:
                                </td>
                                <td>
                                    <asp:TextBox runat="server" ID="EmailSubject" Text='<%# Bind("EmailSubject") %>'
                                        Width="600"></asp:TextBox>
                                </td>
                            </tr>
                            <tr>
                                <td valign="top">
                                    Message:
                                </td>
                                <td>
                                    <asp:TextBox runat="server" ID="EmailMessage" Text='<%# Bind("EmailMessage") %>'
                                        Width="600" TextMode="MultiLine" Rows="35"></asp:TextBox>
                                </td>
                            </tr>
                            <tr>
                                <td>
                                </td>
                                <td>
                                    <asp:Button runat="server" ID="btnSave" Text="Save" CommandName="Save" />
                                </td>
                            </tr>
                        </table>
                    </ItemTemplate>
                </asp:Repeater>
            </td>
            <td width="20">
            </td>
            <td valign="top">
                <asp:SqlDataSource ID="rsLang" runat="server" ConnectionString="<%$ ConnectionStrings:cMain %>"
                    SelectCommand="OfficeLangs_Get" SelectCommandType="StoredProcedure">
                    <SelectParameters>
                        <asp:ControlParameter ControlID="OfficeID" Name="OfficeID" PropertyName="Text" Type="Int32" />
                    </SelectParameters>
                </asp:SqlDataSource>
                <asp:DropDownList runat="server" ID="LanguageID" DataSourceID="rsLang" DataTextField="LanguageName"
                    DataValueField="LanguageID" AutoPostBack="true">
                </asp:DropDownList>
                &nbsp; &nbsp;
                <asp:Button runat="server" ID="btnCopy" Text="Copy" OnClientClick="return confirm('This will overwrite the current text. Proceed?');" />
                <asp:Repeater runat="server" ID="tabLang" DataSourceID="rsLang">
                    <ItemTemplate>
                        <table runat="server" id="tab1">
                            <tr>
                                <td valign="top">
                                    Subject:
                                </td>
                                <td>
                                    <asp:Label runat="server" ID="EmailSubject" Text='<%# Eval("EmailSubject") %>' Width="600"></asp:Label>
                                </td>
                            </tr>
                            <tr>
                                <td valign="top">
                                    Message:
                                </td>
                                <td>
                                    <asp:Label runat="server" ID="EmailMessage" Text='<%# Eval("EmailMessage") %>' Width="600"
                                        TextMode="MultiLine" Rows="35"></asp:Label>
                                </td>
                            </tr>
                        </table>
                    </ItemTemplate>
                </asp:Repeater>
            </td>
        </tr>
    </table>
</asp:Content>
