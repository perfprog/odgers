<%@ Page Language="VB" Trace="false" Debug="false" MasterPageFile="~/Lang/Lang.master"
    ValidateRequest="False" AutoEventWireup="false" CodeFile="HoganScales.aspx.vb"
    Inherits="Lang_HoganScales" Title="Hogan Scales" StylesheetTheme="admin" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <asp:SqlDataSource ID="rsA" runat="server" ConnectionString="<%$ ConnectionStrings:cMain %>"
        SelectCommand="SELECT [LanguageID], [EngScaleName], [EngScaleDesc], [ScaleName], [ScaleDesc], ScaleType, AutoID, ScaleID FROM [Lang_HoganScales] WHERE ([LanguageID] = @LanguageID) ORDER BY [scaleType], ScaleID">
        <SelectParameters>
            <asp:CookieParameter CookieName="LanguageID" Name="LanguageID" Type="Byte" />
        </SelectParameters>
    </asp:SqlDataSource>
    <div class="Section">
        Hogan Scales</div>
    <br />
    <asp:Label runat="server" ID="Message" CssClass="error" EnableViewState="False"></asp:Label><br />
    <asp:GridView ID="tabA" runat="server" DataSourceID="rsA" Width="750px" CellPadding="4"
        AutoGenerateColumns="False" ShowFooter="True">
        <HeaderStyle CssClass="headrow" />
        <AlternatingRowStyle CssClass="altrow" />
        <Columns>
            <asp:TemplateField HeaderText="LFScaleID">
                <ItemTemplate>
                    <asp:Label ID="scaleType" runat="server" Text='<%# Eval("ScaleType") %>'></asp:Label>
                    <asp:Label ID="ScaleID" runat="server" Text='<%# Eval("ScaleID") %>'></asp:Label>
                    <asp:Label ID="autoID" runat="server" Visible="False" Text='<%# Eval("AutoID") %>'></asp:Label>
                </ItemTemplate>
            </asp:TemplateField>
            <asp:TemplateField HeaderText="ScaleName" SortExpression="EngScaleName" ItemStyle-VerticalAlign="Bottom">
                <ItemTemplate>
                    <asp:Label ID="Label1" runat="server" Text='<%# Bind("EngScaleName") %>'></asp:Label>
                    <asp:TextBox ID="ScaleName" runat="server" Text='<%# Bind("ScaleName") %>' Columns="40"
                        SkinID="1"></asp:TextBox><br />
                    Max. Allowed:
                    <asp:Label runat="server" ID="maxlength1" ForeColor="Green" Text='<%# Len(Eval("EngScaleName")) %>'></asp:Label>&nbsp
                    &nbsp; Chars Left:
                    <asp:Label runat="server" ID="charsleft1"></asp:Label>
                </ItemTemplate>
            </asp:TemplateField>
            <asp:TemplateField HeaderText="ScaleDesc" SortExpression="EngScaleDesc" ItemStyle-VerticalAlign="Bottom">
                <ItemTemplate>
                    <asp:Label ID="Label2" runat="server" Text='<%# Bind("EngScaleDesc") %>'></asp:Label>
                    <asp:TextBox ID="ScaleDesc" runat="server" Text='<%# Bind("ScaleDesc") %>' SkinID="2"
                        TextMode="MultiLine" Rows="2" Columns="60"></asp:TextBox>
                    Max. Allowed:
                    <asp:Label runat="server" ID="maxlength2" ForeColor="Green" Text='<%# Len(Eval("EngScaleDesc")) %>'></asp:Label>&nbsp
                    &nbsp; Chars Left:
                    <asp:Label runat="server" ID="charsleft2"></asp:Label>
                </ItemTemplate>
                <FooterTemplate>
                    <asp:Button runat="server" ID="btnSave" Text="Save Changes" CommandName="Save" />
                </FooterTemplate>
                <FooterStyle HorizontalAlign="Right" />
            </asp:TemplateField>
        </Columns>
    </asp:GridView>
</asp:Content>
