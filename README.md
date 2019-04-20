# Flickr Project
## My Flickr project, Find images with Flickr service.

Я использовал архитектуру MVP (Model-View-Presenter).
Спроектировал и реализовал View (FlickerViewController), Presenter(FlickerPresenter) и Model в виде сервиса (NetworkService).

Основная функция приложения - поиск картинок в интернете по введенной строке.
Вводим текст (на английском языке) в серч бар, нажимаем поиск и происходит поиск.
Ключевые фичи:
-Бесконечная прокрутка (Infinite scroll), если покрутить вниз до конца, то подгрузится вторая страница с картинками на тот же запрос и так далее...
-Локальные пуш-уведомления, после успешного запроса - запоминаем введенный текст и когда пользователь отправляет следующий запрос, то уведомление отправляется и через 10 секунд приходит о том, что вы давно не искали предыдущий запрос.
Также у уведомления есть действия: скрыть уведомление и перейти в приложение, где запустить поиск по ключевому слову.

Отображение картинок в collectionView, при нажатии на картинку, происходит переход на другой экран для редактирования.
На экране редактирования, выбранная картинка представлена более крупно и доступны фильтры - сепия, черно-белый и инверсия цвета.
