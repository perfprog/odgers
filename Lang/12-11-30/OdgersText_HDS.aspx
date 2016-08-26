<%@ Page Language="VB" Trace="False" Debug="False" ValidateRequest="False" MasterPageFile="~/Lang/Lang.master"
    AutoEventWireup="false" CodeFile="OdgersText_HDS.aspx.vb" Inherits="Lang_OdgersText_HPI"
    Title="Odgers HDS Text" StylesheetTheme="Admin" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <asp:SqlDataSource ID="rsScale" runat="server" ConnectionString="<%$ ConnectionStrings:cMain %>"
        SelectCommand="SELECT ScaleID, [ScaleName] FROM [HoganScales] WHERE ([LanguageID] = 1) and ScaleType='HDS' ORDER BY [ScaleName]">
    </asp:SqlDataSource>
    <div class="Section">
        Odgers HDS Text</div>
    <br />
    <table>
        <tr>
            <td valign="top">
                Scale:
            </td>
            <td valign="top">
                <asp:DropDownList runat="server" ID="ScaleID" DataSourceID="rsScale" DataTextField="ScaleName"
                    DataValueField="ScaleID">
                </asp:DropDownList>
            </td>
        </tr>
        <tr>
            <td valign="top">
                Level:</td>
            <td valign="top">
                <asp:DropDownList runat="server" ID="Levelname">
                    <asp:ListItem Text="Low" Value="low"></asp:ListItem>
                    <asp:ListItem Text="Middle" Value="med"></asp:ListItem>
                    <asp:ListItem Text="High" Value="high"></asp:ListItem>
                </asp:DropDownList></td>
        </tr>
        <tr>
            <td valign="top">
            </td>
            <td valign="top">
                <asp:Button runat="server" ID="btnGet" Text="Get Data" /></td>
        </tr>
    </table>
    <asp:SqlDataSource ID="rsA" runat="server" ConnectionString="<%$ ConnectionStrings:cMain %>"
        SelectCommand="SELECT JobRiskDesc, EngJobRiskDesc,[LanguageID], [ScaleID], [LevelName], AutoID FROM [Lang_OdgersText_HDs] WHERE (([LanguageID] = @LanguageID) AND ([ScaleID] = @ScaleID) AND ([LevelName] = @LevelName))">
        <SelectParameters>
            <asp:CookieParameter CookieName="LanguageID" Name="LanguageID" Type="Int16" />
            <asp:ControlParameter ControlID="ScaleID" Name="ScaleID" PropertyName="SelectedValue"
                Type="Int16" />
            <asp:ControlParameter ControlID="Levelname" Name="LevelName" PropertyName="SelectedValue"
                Type="String" />
        </SelectParameters>
    </asp:SqlDataSource>
    <table border="1" cellpadding="3" cellspacing="0" width=600>
        <asp:Repeater ID="tabA" runat="server" DataSourceID="rsA">
            <ItemTemplate>
                <tr>
                    <td valign="top">
                        <asp:Label runat="server" ID="AutoID" Visible="False" Text='<%# Eval("AutoID") %>'></asp:Label>
                        <b>Job Risk Desc: </b>
                        <asp:Label runat="server" ID="EngJobRiskDesc" Text='<%# Eval("EngJobRiskDesc") %>'></asp:Label>
                        <br /><br /><asp:TextBox TextMode="Multiline" Rows="10" Columns="50" runat="server" ID="JobRiskDesc"
                            Text='<%# Bind("JobRiskDesc") %>' SkinID=1></asp:TextBox>
                            <br />
                        Max. Allowed:
                        <asp:Label runat="server" ID="maxlength1" ForeColor="Green" Text='<%# Len(Eval("EngJobRiskDesc")) %>'></asp:Label>&nbsp
                        &nbsp; Chars Left:
                        <%--<asp:Label runat="server" ID="charsleft1" ForeColor="Red"></asp:Label>&nbsp &nbsp;--%>
                        <span id=charsleft1></span>
                    </td>
                </tr>
                <tr>
                    <td align="right">
                        <asp:Button runat="server" ID="btnSave" Text="Save" CommandName="Save1" /></td>
                </tr>
            </ItemTemplate>
        </asp:Repeater>
    </table>
</asp:Content>
