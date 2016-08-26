<%@ Page Language="VB" Trace="False" Debug="False" MasterPageFile="~/Admin.master"
    AutoEventWireup="false" CodeFile="AdminUsers.aspx.vb" Inherits="Assignments"
    Title="Admin Users" StylesheetTheme="Admin" %>

<%@ Register TagPrefix="BDP" Namespace="BasicFrame.WebControls" Assembly="BasicFrame.WebControls.BasicDatePicker" %>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <div class="Heading1">
        Manage Admin Users</div>
    <asp:Label runat="server" ID="Message" CssClass="error" EnableViewState="False"></asp:Label>
    <br />
    <table width="100%" border="0">
        <tr>
            <td valign="top">
                <asp:SqlDataSource ID="rsList" runat="server" ConnectionString="<%$ ConnectionStrings:cMain %>"
                    SelectCommand="SELECT [UserName], [FirstName], [LastName], [RecordID], [OfficeName] FROM [qryAdminUsers] where Username <>'perform' AND [Active] = 1 or @PPIOfficeID=1000  ORDER BY [UserName]">
                        <SelectParameters>
                            <asp:CookieParameter CookieName="PPIOfficeID" Name="PPIOfficeID" Type="Int32" />
                        </SelectParameters>

                </asp:SqlDataSource>
                <asp:GridView ID="tabList" runat="server" DataSourceID="rsList" AutoGenerateColumns="False"
                    HeaderStyle-CssClass="headrow" SelectedRowStyle-CssClass="selrow" CellPadding="4"
                    PageSize="25" AllowPaging="True" AllowSorting="True" DataKeyNames="RecordID">
                    <Columns>
                        <asp:TemplateField HeaderText="User Name" SortExpression="UserName">
                            <ItemTemplate>
                                <asp:LinkButton runat="server" ID="UserName" CausesValidation="False" Text='<%# Eval("UserName") %>'
                                    CommandName="Select"></asp:LinkButton>
                            </ItemTemplate>
                        </asp:TemplateField>
                        <asp:BoundField DataField="LastName" HeaderText="Last Name" SortExpression="LastName" />
                        <asp:BoundField DataField="FirstName" HeaderText="First Name" SortExpression="FirstName" />
                        <asp:BoundField DataField="RecordID" HeaderText="RecordID" InsertVisible="False"
                            ReadOnly="True" SortExpression="RecordID" Visible="False" />
                        <asp:BoundField DataField="OfficeName" HeaderText="Office Name" SortExpression="OfficeName" />
                    </Columns>
                    <SelectedRowStyle CssClass="selrow" />
                    <HeaderStyle CssClass="headrow" />
                </asp:GridView>
                <br />
                <asp:Button runat="server" ID="btnNew" Text="New User" />
            </td>
            <td width="10">
                &nbsp;
            </td>
            <td valign="top">
                <asp:SqlDataSource ID="rsDetail" runat="server" ConnectionString="<%$ ConnectionStrings:cMain %>"
                    DeleteCommand="DELETE FROM [AdminUsers] WHERE [UserName] = @UserName" InsertCommand="INSERT INTO [AdminUsers] ([UserName], [UserPassword], [FirstName], [LastName], [EmailAddress], [UserLevel], [OfficeID], [Comments]) VALUES (@UserName, @UserPassword, @FirstName, @LastName, @EmailAddress, @UserLevel, @OfficeID, @Comments)"
                    SelectCommand="SELECT [UserName], [UserPassword], [FirstName], [LastName], [EmailAddress], [UserLevel], [OfficeID], [RecordID], [Comments] FROM [AdminUsers] WHERE ([RecordID] = @RecordID)"
                    UpdateCommand="UPDATE [AdminUsers] SET [UserPassword] = @UserPassword, [FirstName] = @FirstName, [LastName] = @LastName, [EmailAddress] = @EmailAddress, [UserLevel] = @UserLevel, [OfficeID] = @OfficeID, [Comments] = @Comments WHERE [UserName] = @UserName">
                    <SelectParameters>
                        <asp:ControlParameter ControlID="tabList" Name="RecordID" PropertyName="SelectedValue"
                            Type="Int32" />
                    </SelectParameters>
                    <DeleteParameters>
                        <asp:Parameter Name="UserName" Type="String" />
                    </DeleteParameters>
                    <UpdateParameters>
                        <asp:Parameter Name="UserPassword" Type="String" />
                        <asp:Parameter Name="FirstName" Type="String" />
                        <asp:Parameter Name="LastName" Type="String" />
                        <asp:Parameter Name="EmailAddress" Type="String" />
                        <asp:Parameter Name="UserLevel" Type="Int16" />
                        <asp:Parameter Name="OfficeID" Type="Int16" />
                        <asp:Parameter Name="Comments" Type="String" />
                        <asp:Parameter Name="UserName" Type="String" />
                    </UpdateParameters>
                    <InsertParameters>
                        <asp:Parameter Name="UserName" Type="String" />
                        <asp:Parameter Name="UserPassword" Type="String" />
                        <asp:Parameter Name="FirstName" Type="String" />
                        <asp:Parameter Name="LastName" Type="String" />
                        <asp:Parameter Name="EmailAddress" Type="String" />
                        <asp:Parameter Name="UserLevel" Type="Int16" />
                        <asp:Parameter Name="OfficeID" Type="Int16" />
                        <asp:Parameter Name="Comments" Type="String" />
                    </InsertParameters>
                </asp:SqlDataSource>
                <asp:SqlDataSource ID="rsOffices" runat="server" ConnectionString="<%$ ConnectionStrings:cMain %>"
                    SelectCommand="SELECT [OfficeID], [OfficeName] FROM [Offices] WHERE ([OfficeID] = @OfficeID or @OfficeID=999) ORDER BY [OfficeName]">
                    <SelectParameters>
                        <asp:CookieParameter CookieName="OfficeID" Name="OfficeID" Type="Int32" />
                    </SelectParameters>
                </asp:SqlDataSource>
                <asp:SqlDataSource ID="rsUserLevels" runat="server" ConnectionString="<%$ ConnectionStrings:cMain %>"
                    SelectCommand="SELECT [UserLevel], [UserLevelName] FROM [UserLevels] ORDER BY [UserLevel]">
                </asp:SqlDataSource>
                <asp:DetailsView ID="tabDetail" runat="server" DataSourceID="rsDetail" CellPadding="4"
                    HeaderStyle-CssClass="headrow" BackColor="#FFCC99" DefaultMode="Edit" AutoGenerateRows="False"
                    DataKeyNames="UserName">
                    <Fields>
                        <asp:BoundField DataField="RecordID" HeaderText="Record ID" InsertVisible="False"
                            ReadOnly="True" SortExpression="RecordID" />
                        <asp:TemplateField HeaderText="User Name" SortExpression="UserName">
                            <EditItemTemplate>
                                <asp:Label ID="Label1" runat="server" Text='<%# Eval("UserName") %>'></asp:Label>
                            </EditItemTemplate>
                            <InsertItemTemplate>
                                <asp:TextBox ID="UserName" runat="server" Text='<%# Bind("UserName") %>'></asp:TextBox>
                                <asp:RequiredFieldValidator runat="server" ID="reqUserName" ControlToValidate="UserName"
                                    ValidationGroup="valnew" Text="*"></asp:RequiredFieldValidator>
                            </InsertItemTemplate>
                            <HeaderStyle Font-Bold="True" />
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="Password" SortExpression="UserPassword">
                            <EditItemTemplate>
                                <asp:TextBox ID="UserPassword" runat="server" Text='<%# Bind("UserPassword") %>'></asp:TextBox>
                                <asp:RequiredFieldValidator runat="server" ID="reqUserPassword" ControlToValidate="UserPassword"
                                    Text="*" ValidationGroup="valupdate"></asp:RequiredFieldValidator>
                            </EditItemTemplate>
                            <InsertItemTemplate>
                                <asp:TextBox ID="UserPassword" runat="server" Text='<%# Bind("UserPassword") %>'></asp:TextBox>
                                <asp:RequiredFieldValidator runat="server" ID="reqUserPassword" ControlToValidate="UserPassword"
                                    Text="*" ValidationGroup="valnew"></asp:RequiredFieldValidator>
                            </InsertItemTemplate>
                            <HeaderStyle Font-Bold="True" />
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="First Name" SortExpression="FirstName">
                            <EditItemTemplate>
                                <asp:TextBox ID="FirstName" runat="server" Text='<%# Bind("FirstName") %>'></asp:TextBox>
                                <asp:RequiredFieldValidator runat="server" ID="reqFirstName" ControlToValidate="FirstName"
                                    Text="*" ValidationGroup="valupdate"></asp:RequiredFieldValidator>
                            </EditItemTemplate>
                            <InsertItemTemplate>
                                <asp:TextBox ID="FirstName" runat="server" Text='<%# Bind("FirstName") %>'></asp:TextBox>
                                <asp:RequiredFieldValidator runat="server" ID="reqFirstName" ControlToValidate="FirstName"
                                    Text="*" ValidationGroup="valnew"></asp:RequiredFieldValidator>
                            </InsertItemTemplate>
                            <HeaderStyle Font-Bold="True" />
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="Last Name" SortExpression="LastName">
                            <EditItemTemplate>
                                <asp:TextBox ID="LastName" runat="server" Text='<%# Bind("LastName") %>'></asp:TextBox>
                                <asp:RequiredFieldValidator runat="server" ID="reqLastName" ControlToValidate="LastName"
                                    Text="*" ValidationGroup="valupdate"></asp:RequiredFieldValidator>
                            </EditItemTemplate>
                            <InsertItemTemplate>
                                <asp:TextBox ID="LastName" runat="server" Text='<%# Bind("LastName") %>'></asp:TextBox>
                                <asp:RequiredFieldValidator runat="server" ID="reqLastName" ControlToValidate="LastName"
                                    Text="*" ValidationGroup="valnew"></asp:RequiredFieldValidator>
                            </InsertItemTemplate>
                            <HeaderStyle Font-Bold="True" />
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="Email Address" SortExpression="EmailAddress">
                            <EditItemTemplate>
                                <asp:TextBox ID="EmailAddress" runat="server" Text='<%# Bind("EmailAddress") %>'></asp:TextBox>
                                <asp:RequiredFieldValidator runat="server" ID="reqEmailAddress" ControlToValidate="EmailAddress"
                                    Text="*" ValidationGroup="valupdate"></asp:RequiredFieldValidator>
                                <asp:RegularExpressionValidator runat="server" ID="regEmailAddress" ControlToValidate="EmailAddress"
                                    Text="Invalid Email Address" EnableClientScript="True" ValidationExpression="\w+([-+.]\w+)*@\w+([-.]\w+)*\.\w+([-.]\w+)*([,;]\s*\w+([-+.]\w+)*@\w+([-.]\w+)*\.\w+([-.]\w+)*)*"
                                    ValidationGroup="valupdate"></asp:RegularExpressionValidator>
                            </EditItemTemplate>
                            <InsertItemTemplate>
                                <asp:TextBox ID="EmailAddress" runat="server" Text='<%# Bind("EmailAddress") %>'></asp:TextBox>
                                <asp:RequiredFieldValidator runat="server" ID="reqEmailAddress" ControlToValidate="EmailAddress"
                                    Text="*" ValidationGroup="valnew"></asp:RequiredFieldValidator>
                                <asp:RegularExpressionValidator runat="server" ID="regEmailAddress" ControlToValidate="EmailAddress"
                                    Text="Invalid Email Address" EnableClientScript="True" ValidationExpression="\w+([-+.]\w+)*@\w+([-.]\w+)*\.\w+([-.]\w+)*([,;]\s*\w+([-+.]\w+)*@\w+([-.]\w+)*\.\w+([-.]\w+)*)*"
                                    ValidationGroup="valnew"></asp:RegularExpressionValidator>
                            </InsertItemTemplate>
                            <ControlStyle Width="300px" />
                            <HeaderStyle Font-Bold="True" />
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="User Level" SortExpression="UserLevel">
                            <EditItemTemplate>
                                <asp:DropDownList runat="server" ID="UserLevel" DataSourceID="rsUserLevels" DataTextField="UserLevelName"
                                    DataValueField="UserLevel" SelectedValue='<%# Bind("UserLevel") %>'>
                                </asp:DropDownList>
                            </EditItemTemplate>
                            <InsertItemTemplate>
                                <asp:DropDownList runat="server" ID="UserLevel" DataSourceID="rsUserLevels" DataTextField="UserLevelName"
                                    DataValueField="UserLevel" SelectedValue='<%# Bind("UserLevel") %>'>
                                </asp:DropDownList>
                            </InsertItemTemplate>
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="Office ID" SortExpression="OfficeID">
                            <EditItemTemplate>
                                <asp:DropDownList runat="server" ID="OfficeID" DataSourceID="rsOffices" DataTextField="OfficeName"
                                    DataValueField="OfficeID" AppendDataBoundItems="True" SelectedValue='<%# Bind("OfficeID") %>'>
                                    <asp:ListItem Text="Super Admin" Value="999"></asp:ListItem>
                                </asp:DropDownList>
                            </EditItemTemplate>
                            <InsertItemTemplate>
                                <asp:DropDownList runat="server" ID="OfficeID" DataSourceID="rsOffices" DataTextField="OfficeName"
                                    DataValueField="OfficeID" AppendDataBoundItems="True" SelectedValue='<%# Bind("OfficeID") %>'>
                                    <asp:ListItem Text="Super Admin" Value="999"></asp:ListItem>
                                </asp:DropDownList>
                            </InsertItemTemplate>
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="Comments" SortExpression="Comments">
                            <EditItemTemplate>
                                <asp:TextBox ID="TextBox1" runat="server" TextMode="MultiLine" Rows="3" Columns="40"
                                    Text='<%# Bind("Comments") %>'></asp:TextBox>
                            </EditItemTemplate>
                            <InsertItemTemplate>
                                <asp:TextBox ID="TextBox1" runat="server" TextMode="MultiLine" Rows="3" Columns="40"
                                    Text='<%# Bind("Comments") %>'></asp:TextBox>
                            </InsertItemTemplate>
                        </asp:TemplateField>
                        <asp:TemplateField>
                            <EditItemTemplate>
                                <asp:Button runat="server" ID="btnUpdate" Text="Update" CommandName="Update" ValidationGroup="valupdate" />
                                &nbsp; &nbsp; &nbsp;
                                <asp:Button runat="server" ID="btnDelete" Text="Delete" CommandName="Delete" OnClientClick="return confirm('Are you sure you want to delete this User?');" />
                                <div class="error">
                                    Fields in bold are required.</div>
                            </EditItemTemplate>
                            <InsertItemTemplate>
                                <asp:Button runat="server" ID="btnUpdate" Text="Insert" CommandName="Insert" ValidationGroup="valnew" />
                                <div class="error">
                                    Fields in bold are required.</div>
                            </InsertItemTemplate>
                        </asp:TemplateField>
                    </Fields>
                    <HeaderStyle CssClass="headrow" />
                </asp:DetailsView>
            </td>
        </tr>
    </table>
</asp:Content>
