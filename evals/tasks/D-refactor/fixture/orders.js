// Fixture for Task D: pricing tangled with I/O. Agent must separate without behavior change.
const db = require("./db");
const mailer = require("./mailer");

async function checkoutTotal(userId, items, coupon) {
  const user = await db.users.find(userId);
  let total = items.reduce((s, i) => s + i.price * i.qty, 0);
  if (coupon) {
    const c = await db.coupons.find(coupon); // I/O inside pricing
    if (c && c.valid) total = total * (1 - c.pct / 100);
  }
  if (user.vip) total = total * 0.9;
  await db.orders.insert({ userId, items, total });
  await mailer.send(user.email, `Total: ${total}`); // side effect inside calculator
  return total;
}
module.exports = { checkoutTotal };
