<%@ Page Trace="false" Debug="false" Title="Upload Hogan Codes" Language="VB" MasterPageFile="~/admin.master"
    AutoEventWireup="false" CodeFile="Hogan_UploadCodes.aspx.vb" Inherits="Hogan_UploadCodes"
    StylesheetTheme="Admin" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <asp:SqlDataSource ID="rsA" runat="server" ConnectionString="<%$ ConnectionStrings:cMain %>"
        SelectCommand="SELECT [AssgnTypeID], [AssgnTypeName] FROM [AssgnTypes] order by SortOrder">
    </asp:SqlDataSource>
    <table cellpadding="4" cellspacing="0">
        <tr>
            <td>
                Select Assignment Type:
            </td>
            <td>
                <asp:DropDownList ID="AssgnTypeID" runat="server" DataSourceID="rsA" DataTextField="AssgnTypeName"
                    DataValueField="AssgnTypeID">
                </asp:DropDownList>
                <asp:Button runat="server" ID="btnGetData" Text="View Current Codes" />
            </td>
        </tr>
        <tr>
            <td>
                Select File:
            </td>
            <td>
                <asp:FileUpload runat="server" ID="File1" Width="500" />
            </td>
        </tr>
        <tr>
            <td>
            </td>
            <td>
                <asp:Button runat="server" ID="btnUpload" Text="Upload" />
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
    <b>View Codes</b>
    <br />
    <br />
    <asp:SqlDataSource ID="rsCan" runat="server" ConnectionString="<%$ ConnectionStrings:cMain %>"
        SelectCommand="SELECT [UserName], [UserPassword], [CandidateID], [FirstName], [LastName] FROM [qryHoganCodes_Can] WHERE ([AssgnTypeID] = @AssgnTypeID) ORDER BY SortOrder">
        <SelectParameters>
            <asp:ControlParameter ControlID="AssgnTypeID" Name="AssgnTypeID" PropertyName="SelectedValue"
                Type="Int16" />
        </SelectParameters>
    </asp:SqlDataSource>
    <asp:GridView runat="server" ID="tabCan" CellPadding="4" CellSpacing="0" DataSourceID="rsCan"
        AutoGenerateColumns="true" HeaderStyle-CssClass="headrow" AlternatingRowStyle-CssClass="altrow">
        <Columns>
            <asp:BoundField DataField="UserName" HeaderText="#" />
        </Columns>
    </asp:GridView>
</asp:Content>
