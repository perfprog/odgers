<%@ Page Language="VB" Trace="false" Debug="false" ValidateRequest="false" MasterPageFile="~/Lang/Lang.master"
    AutoEventWireup="false" CodeFile="EmailReports.aspx.vb" Inherits="Lang_ReportText"
    Title="Text for Emailing Reports" StylesheetTheme="Admin" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <asp:SqlDataSource ID="rsA" runat="server" ConnectionString="<%$ ConnectionStrings:cMain %>"
        SelectCommand="SELECT [LanguageID], [LanguageName], [RptEmailSubject], [RptEmailMessage], [EngRptEmailSubject], [EngRptEmailMessage] FROM [Lang_EmailReports] WHERE ([LanguageID] = @LanguageID)">
        <SelectParameters>
            <asp:CookieParameter CookieName="LanguageID" DefaultValue="1" Name="LanguageID" Type="Byte" />
        </SelectParameters>
    </asp:SqlDataSource>
    <div class="Section">
        Text for Emailing Reports</div>
    <br />
    <asp:Label runat="server" ID="Message" CssClass="error" EnableViewState="False"></asp:Label><br />
    <asp:GridView ID="tabA" runat="server" DataSourceID="rsA" Width="750px" CellPadding="4"
        AutoGenerateColumns="False" ShowFooter="True">
        <HeaderStyle CssClass="headrow" />
        <AlternatingRowStyle CssClass="altrow" />
        <Columns>
            <asp:TemplateField HeaderText="Subject" ItemStyle-VerticalAlign="Top">
                <ItemTemplate>
                    <asp:Label ID="EngEmailSubject" runat="server" Text='<%# Eval("EngRptEmailSubject") %>'></asp:Label>
                    <br />
                    <asp:TextBox ID="RptEmailSubject" runat="server" Text='<%# Bind("RptEmailSubject") %>'
                        Columns="60" TextMode="SingleLine" SkinID="2"></asp:TextBox>
                    <br />
                    Max. Allowed:
                    <asp:Label runat="server" ID="maxlength2" ForeColor="Green" Text='<%# Len(Eval("EngRptEmailSubject")) %>'></asp:Label>&nbsp
                    &nbsp; Chars Left:
                    <asp:Label runat="server" ID="charsleft2"></asp:Label>
                </ItemTemplate>
            </asp:TemplateField>
            <asp:TemplateField HeaderText="Message" ItemStyle-VerticalAlign="Bottom">
                <ItemTemplate>
                    <asp:Label ID="LanguageID" runat="server" Visible="False" Text='<%# Eval("LanguageID") %>'></asp:Label>
                    <asp:Label ID="EngRptEmailMessage" runat="server" Text='<%# Bind("EngRptEmailMessage") %>'></asp:Label>
                    <br />
                    <asp:TextBox ID="RptEmailMessage" runat="server" Text='<%# Bind("RptEmailMessage") %>'
                        Columns="60" Rows="20" TextMode="MultiLine" SkinID="1"></asp:TextBox>
                    <br />
                    Max. Allowed:
                    <asp:Label runat="server" ID="maxlength1" ForeColor="Green" Text='<%# Len(Eval("EngRptEmailMessage")) %>'></asp:Label>&nbsp
                    &nbsp; Chars Left:
                    <asp:Label runat="server" ID="charsleft1"></asp:Label>
                </ItemTemplate>
                <FooterTemplate>
                    <asp:Button runat="server" ID="btnSave" Text="Save Changes" CommandName="Save" />
                </FooterTemplate>
                <FooterStyle HorizontalAlign="Right" />
            </asp:TemplateField>
        </Columns>
    </asp:GridView>
</asp:Content>
