const functions = require("firebase-functions");
require("dotenv").config();
const stripe = require("stripe")(process.env.SECRET);

exports.payNow = functions.https.onRequest(async (req, res) => {
  const { number, month, year, cvc, amount, name } = req.body;

  await stripe.tokens
    .create({
      card: {
        number: number,
        exp_month: month,
        exp_year: year,
        cvc: cvc,
        name: name,
      },
    })
    .then(async (value) => {
      await stripe.charges
        .create({
          amount: amount,
          currency: "EUR",
          source: value.id,
          description: "Subscription has been done",
        })
        .then((newVal) => {
          res.send({ result: newVal });
        })
        .catch((err) => {
          res.send({ error: err.message });
        });
    })
    .catch((err) => {
      res.send({ error: err.message });
    });
});

exports.cancelPayment = functions.https.onRequest(async (req, res) => {
  const { paymentId } = req.body;

  await stripe.refunds
    .create({
      charge: paymentId,
    })
    .then((val) => {
      if (val.status === "succeeded") {
        res.send({
          success: true,
          message: "Payment canceled successfully",
          data: val,
        });
      } else {
        res.send({ success: false, message: "Failed to cancel the payment" });
      }
    })
    .catch((err) => {
      res.send({ success: false, message: err.raw.code });
    });
});
