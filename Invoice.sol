pragma solidity ^0.6.0;

contract Invoice {
    // Struct to store invoice data
    struct InvoiceData {
        bytes32 buyerPAN;
        bytes32 sellerPAN;
        uint256 amount;
        uint256 date;
        bool paid;
    }

    // Mapping from invoice ID to invoice data
    mapping(uint => InvoiceData) public invoices;
    // Array of invoice IDs
    uint[] public invoiceIDs;

    // Add an invoice to the ledger
    function addInvoice(bytes32 _buyerPAN, bytes32 _sellerPAN, uint256 _amount, uint256 _date) public {
        uint id = invoiceIDs.push(invoiceIDs.length + 1) - 1;
        invoices[id] = InvoiceData(_buyerPAN, _sellerPAN, _amount, _date, false);
    }

    // Mark an invoice as paid
    function markInvoiceAsPaid(uint _invoiceID) public {
        invoices[_invoiceID].paid = true;
    }

    // Get the data for a specific invoice
    function getInvoice(uint _invoiceID) public view returns (bytes32, bytes32, uint256, uint256, bool) {
        InvoiceData storage invoice = invoices[_invoiceID];
        return (invoice.buyerPAN, invoice.sellerPAN, invoice.amount, invoice.date, invoice.paid);
    }

    // Get the number of invoices in the ledger
    function getInvoiceCount() public view returns (uint) {
        return invoiceIDs.length;
    }

    // Get the PANs for all invoices in the ledger
    function getInvoicePANs() public view returns (bytes32[]) {
        bytes32[] memory panArray = new bytes32[](invoiceIDs.length);
        for (uint i = 0; i < invoiceIDs.length; i++) {
            InvoiceData storage invoice = invoices[invoiceIDs[i]];
            panArray[i] = invoice.buyerPAN;
        }
        return panArray;
    }
}