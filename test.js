const Invoice = artifacts.require("Invoice");

contract("Invoice", accounts => {
    let invoice;

    beforeEach(async () => {
        invoice = await Invoice.new();
    });

    it("should add an invoice to the ledger", async () => {
        await invoice.addInvoice("0x01", "0x02", 1000, 1607702400);
        const count = await invoice.getInvoiceCount();
        assert.equal(count, 1);
    });

    it("should mark an invoice as paid", async () => {
        await invoice.addInvoice("0x01", "0x02", 1000, 1607702400);
        await invoice.markInvoiceAsPaid(0);
        const invoiceData = await invoice.getInvoice(0);
        assert.equal(invoiceData[4], true);
    });
});
