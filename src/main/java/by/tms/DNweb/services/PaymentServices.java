package by.tms.DNweb.services;

import by.tms.DNweb.bot.TelegramBot;
import by.tms.DNweb.entity.Card;
import by.tms.DNweb.entity.Currency;
import by.tms.DNweb.repository.CardRepository;
import by.tms.DNweb.repository.CurrencyRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class PaymentServices {


    @Autowired
    TelegramBot telegramBot;

    @Autowired
    CardRepository cardRepository;

    @Autowired
    CurrencyRepository currencyRepository;

//    генерация кода безопасности
    public String generateConfirmKey() {
        String confirmKey = String.valueOf((int)(Math.random() * ((9999 - 1001) + 1)) + 1001);
        return confirmKey;
    }

    //    генерация номера карты
    public String generateCardNumber() {
        StringBuilder cardNumber = new StringBuilder();
        for(int i = 0; i < 4; i++) {
            cardNumber.append((int)(Math.random() * 8999 + 1001));
            if(i < 3) {
                cardNumber.append(" ");
            };
        }
        return cardNumber.toString();
    }

//    зачисление средств на карту
    public void debit(Card card, double amount) {
        card.setRest(card.getRest() - amount);
        cardRepository.save(card);
        telegramBot.sendMessage(
                "C карты: " + card.getCardNumber() + " произошло списание " +
                        amount + " " + card.getCurrency());
    }

//    списание средств с карты
    public void credit(Card card, double amount) {
        card.setRest(card.getRest() + amount);
        cardRepository.save(card);
        telegramBot.sendMessage(
                "На карту: " + card.getCardNumber() + " зачислено " +
                        amount + " " + card.getCurrency());
    }

    public double convert(double amount, String base, String rated) {
        Currency currency = currencyRepository.findCurrencyByBaseCurrencyAndAndRatedCurrency(base, rated);
        double convertedAmount = amount * currency.getBaseCurrencyNominal() / currency.getRate();
        convertedAmount = (double) Math.round(convertedAmount * 100) / 100;
        return convertedAmount;
    }
}