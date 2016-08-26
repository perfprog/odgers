<%@ Page Language="VB" Trace="True" Debug="True" AutoEventWireup="false" CodeFile="Reports_Log_v2.aspx.vb" Inherits="test_files" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" >
<head runat="server">
    <title>Untitled Page</title>
</head>
<body>
    <form id="form1" runat="server">
    <div>
    <asp:TextBox runat=server ID=DirName></asp:TextBox>
    <asp:Button runat=server ID=btnList Text="List" />
    <asp:Button runat=server ID=btnImport Text="Import Data" />
    </div>
    </form>
</body>
</html>
