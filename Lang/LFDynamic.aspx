<%@ Page Language="VB" Trace="false" Debug="false" MasterPageFile="~/Lang/Lang.master"
    ValidateRequest="False" AutoEventWireup="false" CodeFile="LFDynamic.aspx.vb" Inherits="Lang_Dimensions"
    Title="Leaderfit Dynamic Text" StylesheetTheme="admin" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <asp:SqlDataSource ID="rsScale" runat="server" ConnectionString="<%$ ConnectionStrings:cMain %>"
        SelectCommand="SELECT ScaleID, [ScaleName] FROM [Scales] WHERE ([LanguageID] = 1) and IsHogan=0 Order by ScaleID">
    </asp:SqlDataSource>
    <div class="Section">
        Leaderfit Scales Dynamic Text</div>
    <br />
    <asp:Label runat="server" ID="Message" CssClass="error" EnableViewState="False"></asp:Label><br />
    <table>
        <tr>
            <td valign="top">
                <b>LeaderFit Scale:</b>
            </td>
            <td>
                <asp:RadioButtonList runat="server" ID="LFScaleID" DataSourceID="rsScale" DataTextField="ScaleName"
                    DataValueField="ScaleID" RepeatDirection="Horizontal" RepeatColumns="3" AutoPostBack="true">
                </asp:RadioButtonList>
            </td>
        </tr>
    </table>
    <asp:SqlDataSource ID="rsA" runat="server" ConnectionString="<%$ ConnectionStrings:cMain %>"
        SelectCommand="SELECT LFScaleID, HPIScaleID, LFScaleName, HPIScaleName, [LanguageID], [EngHighText], [HighText], EngMedText, MedText, EngLowText, LowText, AutoID FROM [Lang_LFtext] WHERE ([LanguageID] = @LanguageID) and LFScaleID=@LFScaleID ORDER BY LFScaleID, HPIScaleID">
        <SelectParameters>
            <asp:CookieParameter CookieName="LanguageID" Name="LanguageID" Type="Byte" />
            <asp:ControlParameter ControlID="LFScaleID" Name="LFScaleID" PropertyName="SelectedValue" />
        </SelectParameters>
    </asp:SqlDataSource>
    <asp:GridView ID="tabA" runat="server" DataSourceID="rsA" Width="750px" CellPadding="4"
        AutoGenerateColumns="False" ShowFooter="True" EnableModelValidation="True">
        <HeaderStyle CssClass="headrow" />
        <AlternatingRowStyle CssClass="altrow" />
        <Columns>
            <asp:TemplateField HeaderText="HPI Scale Name" SortExpression="EngScaleName" ItemStyle-VerticalAlign="Bottom">
                <ItemTemplate>
                    <asp:Label ID="autoID" runat="server" Visible="False" Text='<%# Eval("AutoID") %>'></asp:Label>
                    <asp:Label ID="Label2" runat="server" Font-Bold="true" Text='<%# Bind("HPIScaleName") %>'></asp:Label>
                </ItemTemplate>
                <ItemStyle VerticalAlign="Top" />
            </asp:TemplateField>
            <asp:TemplateField HeaderText="High Text" ItemStyle-VerticalAlign="Bottom">
                <ItemTemplate>
                    <asp:Label ID="EngHighText" runat="server" Text='<%# Bind("EngHighText") %>'></asp:Label>
                    <asp:TextBox ID="HighText" runat="server" Text='<%# Bind("Hightext") %>' TextMode="MultiLine"
                        Rows="14" Columns="30" SkinID="3"></asp:TextBox>
                    Max. Allowed:
                    <asp:Label runat="server" ID="maxlength3" ForeColor="Green" Text='<%# Len(Eval("EngHighText")) %>'></asp:Label>&nbsp
                    &nbsp; Chars Left:
                    <asp:Label runat="server" ID="charsleft3"></asp:Label></ItemTemplate>
            </asp:TemplateField>
            <asp:TemplateField HeaderText="Medium Text" ItemStyle-VerticalAlign="Bottom">
                <ItemTemplate>
                    <asp:Label ID="EngMedText" runat="server" Text='<%# Bind("EngMedText") %>'></asp:Label>
                    <asp:TextBox ID="MedText" runat="server" Text='<%# Bind("MedText") %>' TextMode="MultiLine"
                        Rows="14" Columns="30" SkinID="4"></asp:TextBox>
                    Max. Allowed:
                    <asp:Label runat="server" ID="maxlength4" ForeColor="Green" Text='<%# Len(Eval("EngMedtext")) %>'></asp:Label>&nbsp
                    &nbsp; Chars Left:
                    <asp:Label runat="server" ID="charsleft4"></asp:Label></ItemTemplate>
                <FooterStyle HorizontalAlign="Right" />
            </asp:TemplateField>
            <asp:TemplateField HeaderText="Low Text" ItemStyle-VerticalAlign="Bottom">
                <ItemTemplate>
                    <asp:Label ID="EngLowText" runat="server" Text='<%# Bind("EngLowText") %>'></asp:Label>
                    <asp:TextBox ID="LowText" runat="server" Text='<%# Bind("LowText") %>' TextMode="MultiLine"
                        Rows="14" Columns="30" SkinID="5"></asp:TextBox>
                    Max. Allowed:
                    <asp:Label runat="server" ID="maxlength5" ForeColor="Green" Text='<%# Len(Eval("EngLowText")) %>'></asp:Label>&nbsp
                    &nbsp; Chars Left:
                    <asp:Label runat="server" ID="charsleft5"></asp:Label></ItemTemplate>
                <FooterTemplate>
                    <asp:Button runat="server" ID="btnSave" Text="Save Changes" CommandName="Save" />
                </FooterTemplate>
                <FooterStyle HorizontalAlign="Right" />
            </asp:TemplateField>
        </Columns>
    </asp:GridView>
</asp:Content>
