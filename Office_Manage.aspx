<%@ Page Title="Manage Offices" Trace="false" Debug="false" Language="VB" MasterPageFile="~/admin.master"
    AutoEventWireup="false" CodeFile="Office_Manage.aspx.vb" Inherits="Office_Manage"
    StylesheetTheme="Admin" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <table border="0">
        <tr>
            <td valign="top">
                <asp:SqlDataSource ID="rsOffices" runat="server" ConnectionString="<%$ ConnectionStrings:cMain %>"
                    SelectCommand="SELECT [OfficeID], [OfficeName], LangsList, AssgnTypeslist, Active FROM [Offices] WHERE ([OfficeID] = @OfficeID AND [Active] = 1 or @OfficeID=999 AND [Active] = 1 or @PPIOfficeID=1000) ORDER BY [OfficeName]">
                    <SelectParameters>
                        <asp:CookieParameter CookieName="OfficeID" Name="OfficeID" Type="Int32" />
                        <asp:CookieParameter CookieName="PPIOfficeID" Name="PPIOfficeID" Type="Int32" />
                    </SelectParameters>
                </asp:SqlDataSource>
                Select Office:
            </td>
            <td>
                <asp:DropDownList runat="server" ID="OfficeID" DataSourceID="rsOffices" DataTextField="OfficeName" OnSelectedIndexChanged ="OfficeID_SelectedIndexChanged"
                    DataValueField="OfficeID" AutoPostBack="True">
                </asp:DropDownList>
            </td>

        <tr <% 
            If Request.Cookies("PPIOfficeID").Value <> 1000 Then
                Response.Write("style=visibility:Hidden")
            End If
            %>>
            <td valign="top">
            
            Status: (Checked for Active)
            <br /><br />
            </td>
            <td>
            <asp:Checkbox runat="server" ID="Active">
            </asp:Checkbox>
            <br /><br />
            </td>
        </tr>
        
        <tr>
            <td colspan="2" class="note">
                <i>Now assign languages and assignment types that the above office will be allowed to
                    access.
                    <ol>
                        <li>The below language selection applies only to candidate emails and custom Odgers
                            reports. It has no bearing on the language selection in the Hogan portal.</li>
                        <li>The numbers in parentheses indicate the number of times that option has been used for the selected Office.
                        </li>
                        <li>The options that are currently in use cannot be unchecked, as that would cause errors
                            in the portal. </li>
                    </ol>
                </i>
            </td>
        </tr>
        <tr>
            <td valign="top">
                Select Language(s):
            </td>
            <td valign="top">
                <asp:SqlDataSource ID="rsLang" runat="server" ConnectionString="<%$ ConnectionStrings:cMain %>"
                    SelectCommand="SELECT [LanguageID], [LanguageName] + ' (' + Convert(nvarchar(4), (Select Count(CandidateID) from qryAssgnCandidates where LanguageID=Languages.LanguageID and OfficeID=@OfficeID)) + ')' as LanguageName FROM [Languages] ORDER BY [LanguageName]">
                    <SelectParameters>
                        <asp:ControlParameter ControlID="OfficeID" Name="OfficeID" PropertyName="SelectedValue" />
                    </SelectParameters>
                </asp:SqlDataSource>
                <asp:CheckBoxList runat="server" ID="LangsList" DataSourceID="rsLang" DataTextField="LanguageName"
                    CellSpacing="6" RepeatDirection="Horizontal" RepeatColumns="2" DataValueField="LanguageID">
                </asp:CheckBoxList>
            </td>
        </tr>
        <tr>
            <td valign="top">
                Select Assignment Type(s):
            </td>
            <td valign="top">
                <asp:SqlDataSource ID="rsTypes" runat="server" ConnectionString="<%$ ConnectionStrings:cMain %>"
                    SelectCommand="SELECT [AssgnTypeID], AssgnTypeName + ' (' + Convert(nvarchar(4), (Select Count(AssgnID) from Assignments where AssgnTypeID=AssgnTypes.AssgnTypeID and OfficeID=@OfficeID)) + ')' as AssgnTypeName FROM [AssgnTypes] ORDER BY [AssgnTypeName]">
                    <SelectParameters>
                        <asp:ControlParameter ControlID="OfficeID" Name="OfficeID" PropertyName="SelectedValue" />
                    </SelectParameters>
                </asp:SqlDataSource>
                <asp:CheckBoxList runat="server" ID="AssgnTypesList" DataSourceID="rsTypes" DataTextField="AssgnTypeName"
                    CellSpacing="6" RepeatDirection="Horizontal" RepeatColumns="2" DataValueField="AssgnTypeID">
                </asp:CheckBoxList>
            </td>
        </tr>

        <tr>
            <td>
            </td>
            <td>
                <br /><br /><asp:Button runat="server" ID="btnSave" Text="Save Changes" />
                <br />
                <asp:Label runat="server" ID="Message" EnableViewState="false" CssClass="error"></asp:Label>
            </td>
        </tr>
    </table>
</asp:Content>
