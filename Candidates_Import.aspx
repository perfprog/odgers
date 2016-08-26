<%@ Page Title="Import Candidates" Trace="false" Debug="false" Language="VB" MasterPageFile="~/admin.master"
    AutoEventWireup="false" StylesheetTheme="Admin" CodeFile="Candidates_Import.aspx.vb"
    Inherits="Basecamp" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <table cellpadding="0" cellspacing="4" border="0">
        <tr>
            <td colspan="2">
                Import Candidates for
                <asp:SqlDataSource ID="rsAssgn" runat="server" ConnectionString="<%$ ConnectionStrings:cMain %>"
                    SelectCommand="SELECT [AssgnID], [ClientName], [AssgnTypeName] FROM [qryAssgnList] WHERE ([AssgnID] = @AssgnID)">
                    <SelectParameters>
                        <asp:QueryStringParameter Name="AssgnID" QueryStringField="AssgnID" Type="Int32" />
                    </SelectParameters>
                </asp:SqlDataSource>
            </td>
        </tr>
        <tr>
            <td colspan="2">
                <asp:GridView runat="server" ID="tabAssgn" DataSourceID="rsAssgn" AutoGenerateColumns="true"
                    HeaderStyle-CssClass="headrow" CellPadding="3" CellSpacing="3">
                </asp:GridView>
            </td>
        </tr>
        <tr>
            <td>
                File to Upload:
            </td>
            <td>
                <asp:FileUpload runat="server" ID="CanImport1" ToolTip="Must be in csv format" />
            </td>
        </tr>
        <tr> 
            <td>
            </td>
            <td>
                <asp:Button runat="server" ID="btnSubmit" Text="Upload" />
            </td>
        </tr>
        <tr>
            <td>
            </td>
            <td>
                <asp:Label runat="server" ID="Message" EnableViewState="false" CssClass="error"></asp:Label>
            </td>
        </tr>
    </table>
    <table cellpadding="0" cellspacing="4" border="0">
        <tr>
            <td>
                Candidates
            </td>
        </tr>
        <tr>
            <td>
                <asp:SqlDataSource ID="rsCan" runat="server" ConnectionString="<%$ ConnectionStrings:cMain %>"
                    SelectCommand="SELECT [FirstName], [LastName], [EmailAddress] FROM [qryAssgnCandidates] WHERE ([AssgnID] = @AssgnID) ORDER BY [CandidateID]">
                    <SelectParameters>
                        <asp:QueryStringParameter Name="AssgnID" QueryStringField="AssgnID" Type="Int32" />
                    </SelectParameters>
                </asp:SqlDataSource>
                <asp:GridView runat="server" ID="tabCan" DataSourceID="rsCan" AutoGenerateColumns="False"
                    HeaderStyle-CssClass="headrow" CellPadding="3" CellSpacing="3">
                    <Columns>
                        <asp:TemplateField>
                            <ItemTemplate>
                                <%# Container.DataItemIndex + 1 & ". " %></ItemTemplate>
                            <ItemStyle HorizontalAlign="Right" />
                        </asp:TemplateField>
                        <asp:BoundField DataField="FirstName" HeaderText="FirstName" SortExpression="FirstName" />
                        <asp:BoundField DataField="LastName" HeaderText="LastName" SortExpression="LastName" />
                        <asp:BoundField DataField="EmailAddress" HeaderText="EmailAddress" SortExpression="EmailAddress" />
                    </Columns>
                    <HeaderStyle CssClass="headrow"></HeaderStyle>
                </asp:GridView>
            </td>
        </tr>
    </table>
</asp:Content>
