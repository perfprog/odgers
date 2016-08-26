<%@ Page Title="Basecamp Data" Trace="false" Debug="false" Language="VB" MasterPageFile="~/admin.master"
    AutoEventWireup="false" StylesheetTheme="Admin" CodeFile="Basecamp.aspx.vb" Inherits="Basecamp" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <asp:SqlDataSource ID="rsCan" runat="server" ConnectionString="<%$ ConnectionStrings:cMain %>"
        SelectCommand="SELECT [AssgnID], [CandidateID], [CandidateName], [EmailAddress], [Phone_Cell], [HoganUserName], [LevelName], [LangName] FROM [qryBasecamp_Src] WHERE HoganUserName is not null and ([AssgnID] = @AssgnID) ORDER BY [CandidateName]">
        <SelectParameters>
            <asp:QueryStringParameter DefaultValue="15" Name="AssgnID" QueryStringField="AssgnID"
                Type="Int32" />
        </SelectParameters>
    </asp:SqlDataSource>
    <asp:GridView runat="server" ID="tabCan" DataSourceID="rsCan" AutoGenerateColumns="false"
        HeaderStyle-CssClass="headrow" AlternatingRowStyle-CssClass="altrow" CellPadding="3"
        CellSpacing="0">
        <Columns>
            <asp:BoundField DataField="CandidateName" HeaderText="Name" />
            <asp:BoundField DataField="Phone_Cell" HeaderText="Phone" />
            <asp:BoundField DataField="EmailAddress" HeaderText="Email" />
            <asp:BoundField DataField="LevelName" HeaderText="Level" />
            <asp:BoundField DataField="LangName" HeaderText="Lang" />
            <asp:TemplateField HeaderText="Hogan Potential Report">
                <ItemTemplate>
                    <asp:HyperLink runat="server" ID="hl1" SkinID="EcHPIIML" ></asp:HyperLink>
                </ItemTemplate>
            </asp:TemplateField>

            <asp:TemplateField HeaderText="Hogan Challenge Report">
                <ItemTemplate>
                    <asp:HyperLink runat="server" ID="hl2" SkinID="EcHDSLFCML"></asp:HyperLink>
                </ItemTemplate>
            </asp:TemplateField>

            <asp:TemplateField HeaderText="Hogan Values Report">
                <ItemTemplate>
                    <asp:HyperLink runat="server" ID="hl3" SkinID="EcMVPIIML"></asp:HyperLink>
                </ItemTemplate>
            </asp:TemplateField>

            <asp:TemplateField HeaderText="Hogan Coaching Report">
                <ItemTemplate>
                    <asp:HyperLink runat="server" ID="hl4" SkinID="EcHPIHDSMVPILFCRML"></asp:HyperLink>
                </ItemTemplate>
            </asp:TemplateField>

             <asp:TemplateField HeaderText="Hogan Interpret Report">
                <ItemTemplate>
                    <asp:HyperLink runat="server" ID="hl5" SkinID="EcHBRIV1IML"></asp:HyperLink>
                </ItemTemplate>
            </asp:TemplateField>

            <asp:TemplateField HeaderText="LeaderFit MYC Benchmark Report">
                <ItemTemplate>
                    <asp:HyperLink runat="server" ID="hl6" SkinID="OBBenchmark"></asp:HyperLink>
                </ItemTemplate>
            </asp:TemplateField>

        </Columns>
    </asp:GridView>
</asp:Content>
