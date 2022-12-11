I18n.translations || (I18n.translations = {});
I18n.translations["en"] = I18n.extend((I18n.translations["en"] || {}), {
  "activerecord": {
    "errors": {
      "full_messages": {
        "format": "%{attribute} %{message}"
      },
      "messages": {
        "accepted": "нужно подтвердить",
        "blank": "не может быть пустым",
        "confirmation": "не совпадает с подтверждением",
        "empty": "не может быть пустым",
        "equal_to": "может иметь лишь значение, равное %{count}",
        "even": "может иметь лишь нечетное значение",
        "exclusion": "имеет зарезервированное значение",
        "greater_than": "может иметь лишь значение большее %{count}",
        "greater_than_or_equal_to": "может иметь лишь значение большее или равное %{count}",
        "inclusion": "имеет непредусмотренное значение",
        "invalid": "имеет неверное значение",
        "less_than": "может иметь лишь значение меньшее чем %{count}",
        "less_than_or_equal_to": "может иметь значение меньшее или равное %{count}",
        "not_a_number": "не является числом",
        "odd": "может иметь лишь четное значение",
        "record_invalid": "Validation failed: %{errors}",
        "restrict_dependent_destroy": {
          "has_many": "Cannot delete record because dependent %{record} exist",
          "has_one": "Cannot delete record because a dependent %{record} exists"
        },
        "taken": "уже существует",
        "too_long": {
          "few": "слишком большой длины (не может быть больше чем %{count} символа)",
          "many": "слишком большой длины (не может быть больше чем %{count} символов)",
          "one": "слишком большой длины (не может быть больше чем %{count} символ)",
          "other": "слишком большой длины (не может быть больше чем %{count} символа)"
        },
        "too_short": {
          "few": "недостаточной длины (не может быть меньше %{count} символов)",
          "many": "недостаточной длины (не может быть меньше %{count} символов)",
          "one": "недостаточной длины (не может быть меньше %{count} символа)",
          "other": "недостаточной длины (не может быть меньше %{count} символа)"
        },
        "wrong_length": {
          "few": "неверной длины (может быть длиной ровно %{count} символа)",
          "many": "неверной длины (может быть длиной ровно %{count} символов)",
          "one": "неверной длины (может быть длиной ровно %{count} символ)",
          "other": "неверной длины (может быть длиной ровно %{count} символа)"
        }
      },
      "models": null,
      "template": {
        "body": "Проблемы возникли со следующими полями:",
        "header": {
          "few": "%{model}: сохранение не удалось из-за %{count} ошибок",
          "many": "%{model}: сохранение не удалось из-за %{count} ошибок",
          "one": "%{model}: сохранение не удалось из-за %{count} ошибки",
          "other": "%{model}: сохранение не удалось из-за %{count} ошибки"
        }
      }
    }
  },
  "date": {
    "abbr_day_names": [
      "Sun",
      "Mon",
      "Tue",
      "Wed",
      "Thu",
      "Fri",
      "Sat"
    ],
    "abbr_month_names": [
      null,
      "Jan",
      "Feb",
      "Mar",
      "Apr",
      "May",
      "Jun",
      "Jul",
      "Aug",
      "Sep",
      "Oct",
      "Nov",
      "Dec"
    ],
    "common_abbr_day_names": [
      "Вс",
      "Пн",
      "Вт",
      "Ср",
      "Чт",
      "Пт",
      "Сб"
    ],
    "common_abbr_month_names": [
      null,
      "янв.",
      "февр.",
      "марта",
      "апр.",
      "мая",
      "июня",
      "июля",
      "авг.",
      "сент.",
      "окт.",
      "нояб.",
      "дек."
    ],
    "common_day_names": [
      "воскресенье",
      "понедельник",
      "вторник",
      "среда",
      "четверг",
      "пятница",
      "суббота"
    ],
    "common_month_names": [
      null,
      "января",
      "февраля",
      "марта",
      "апреля",
      "мая",
      "июня",
      "июля",
      "августа",
      "сентября",
      "октября",
      "ноября",
      "декабря"
    ],
    "day_names": [
      "Sunday",
      "Monday",
      "Tuesday",
      "Wednesday",
      "Thursday",
      "Friday",
      "Saturday"
    ],
    "formats": {
      "default": "%Y-%m-%d",
      "long": "%B %d, %Y",
      "short": "%b %d"
    },
    "month_names": [
      null,
      "January",
      "February",
      "March",
      "April",
      "May",
      "June",
      "July",
      "August",
      "September",
      "October",
      "November",
      "December"
    ],
    "order": [
      "year",
      "month",
      "day"
    ],
    "standalone_abbr_day_names": [
      "вс",
      "пн",
      "вт",
      "ср",
      "чт",
      "пт",
      "сб"
    ],
    "standalone_abbr_month_names": [
      null,
      "янв.",
      "февр.",
      "март",
      "апр.",
      "май",
      "июнь",
      "июль",
      "авг.",
      "сент.",
      "окт.",
      "нояб.",
      "дек."
    ],
    "standalone_day_names": [
      "Воскресенье",
      "Понедельник",
      "Вторник",
      "Среда",
      "Четверг",
      "Пятница",
      "Суббота"
    ],
    "standalone_month_names": [
      null,
      "Январь",
      "Февраль",
      "Март",
      "Апрель",
      "Май",
      "Июнь",
      "Июль",
      "Август",
      "Сентябрь",
      "Октябрь",
      "Ноябрь",
      "Декабрь"
    ]
  },
  "datetime": {
    "distance_in_words": {
      "about_x_hours": {
        "few": "около %{count} часов",
        "many": "около %{count} часов",
        "one": "about 1 hour",
        "other": "about %{count} hours"
      },
      "about_x_months": {
        "few": "около %{count} месяцев",
        "many": "около %{count} месяцев",
        "one": "about 1 month",
        "other": "about %{count} months"
      },
      "about_x_years": {
        "few": "около %{count} лет",
        "many": "около %{count} лет",
        "one": "about 1 year",
        "other": "about %{count} years"
      },
      "almost_x_years": {
        "few": "почти %{count} года",
        "many": "почти %{count} лет",
        "one": "almost 1 year",
        "other": "almost %{count} years"
      },
      "half_a_minute": "half a minute",
      "less_than_x_minutes": {
        "few": "меньше %{count} минут",
        "many": "меньше %{count} минут",
        "one": "less than a minute",
        "other": "less than %{count} minutes"
      },
      "less_than_x_seconds": {
        "few": "меньше %{count} секунд",
        "many": "меньше %{count} секунд",
        "one": "less than 1 second",
        "other": "less than %{count} seconds"
      },
      "over_x_years": {
        "few": "больше %{count} лет",
        "many": "больше %{count} лет",
        "one": "over 1 year",
        "other": "over %{count} years"
      },
      "x_days": {
        "few": "%{count} дня",
        "many": "%{count} дней",
        "one": "1 day",
        "other": "%{count} days"
      },
      "x_minutes": {
        "few": "%{count} минуты",
        "many": "%{count} минут",
        "one": "1 minute",
        "other": "%{count} minutes"
      },
      "x_months": {
        "few": "%{count} месяца",
        "many": "%{count} месяцев",
        "one": "1 month",
        "other": "%{count} months"
      },
      "x_seconds": {
        "few": "%{count} секунды",
        "many": "%{count} секунд",
        "one": "1 second",
        "other": "%{count} seconds"
      },
      "x_years": {
        "few": "%{count} года",
        "many": "%{count} лет",
        "one": "1 year",
        "other": "%{count} years"
      }
    },
    "prompts": {
      "day": "Day",
      "hour": "Hour",
      "minute": "Minute",
      "month": "Month",
      "second": "Second",
      "year": "Year"
    }
  },
  "errors": {
    "connection_refused": "Oops! Failed to connect to the Web Console middleware.\nPlease make sure a rails development server is running.\n",
    "format": "%{attribute} %{message}",
    "messages": {
      "accepted": "must be accepted",
      "blank": "can't be blank",
      "carrierwave_download_error": "could not be downloaded",
      "carrierwave_integrity_error": "is not of an allowed file type",
      "carrierwave_processing_error": "failed to be processed",
      "confirmation": "doesn't match %{attribute}",
      "content_type_allowlist_error": "You are not allowed to upload %{content_type} files, allowed types: %{allowed_types}",
      "content_type_denylist_error": "You are not allowed to upload %{content_type} files",
      "empty": "can't be empty",
      "equal_to": "must be equal to %{count}",
      "even": "must be even",
      "exclusion": "is reserved",
      "extension_allowlist_error": "You are not allowed to upload %{extension} files, allowed types: %{allowed_types}",
      "extension_denylist_error": "You are not allowed to upload %{extension} files, prohibited types: %{prohibited_types}",
      "greater_than": "must be greater than %{count}",
      "greater_than_or_equal_to": "must be greater than or equal to %{count}",
      "in": "must be in %{count}",
      "inclusion": "is not included in the list",
      "invalid": "is invalid",
      "less_than": "must be less than %{count}",
      "less_than_or_equal_to": "must be less than or equal to %{count}",
      "max_size_error": "File size should be less than %{max_size}",
      "min_size_error": "File size should be greater than %{min_size}",
      "mini_magick_processing_error": "Failed to manipulate with MiniMagick, maybe it is not an image? Original Error: %{e}",
      "model_invalid": "Validation failed: %{errors}",
      "not_a_number": "is not a number",
      "not_an_integer": "must be an integer",
      "odd": "must be odd",
      "other_than": "must be other than %{count}",
      "present": "must be blank",
      "record_invalid": "Возникли ошибки: %{errors}",
      "required": "must exist",
      "rmagick_processing_error": "Failed to manipulate with rmagick, maybe it is not an image?",
      "taken": "has already been taken",
      "too_long": {
        "few": "слишком большой длины (не может быть больше чем %{count} символа)",
        "many": "слишком большой длины (не может быть больше чем %{count} символов)",
        "one": "is too long (maximum is 1 character)",
        "other": "is too long (maximum is %{count} characters)"
      },
      "too_short": {
        "few": "недостаточной длины (не может быть меньше %{count} символов)",
        "many": "недостаточной длины (не может быть меньше %{count} символов)",
        "one": "is too short (minimum is 1 character)",
        "other": "is too short (minimum is %{count} characters)"
      },
      "vips_processing_error": "Failed to manipulate with vips, maybe it is not an image? Original Error: %{e}",
      "wrong_length": {
        "few": "неверной длины (может быть длиной ровно %{count} символа)",
        "many": "неверной длины (может быть длиной ровно %{count} символов)",
        "one": "is the wrong length (should be 1 character)",
        "other": "is the wrong length (should be %{count} characters)"
      }
    },
    "template": {
      "body": "There were problems with the following fields:",
      "header": {
        "few": "%{model}: сохранение не удалось из-за %{count} ошибок",
        "many": "%{model}: сохранение не удалось из-за %{count} ошибок",
        "one": "1 error prohibited this %{model} from being saved",
        "other": "%{count} errors prohibited this %{model} from being saved"
      }
    },
    "unacceptable_request": "A supported version is expected in the Accept header.\n",
    "unavailable_session": "Session %{id} is no longer available in memory.\n\nIf you happen to run on a multi-process server (like Unicorn or Puma) the process\nthis request hit doesn't store %{id} in memory. Consider turning the number of\nprocesses/workers to one (1) or using a different server in development.\n"
  },
  "flash": {
    "actions": {
      "create": {
        "notice": "%{resource_name} was successfully created."
      },
      "destroy": {
        "alert": "%{resource_name} could not be destroyed.",
        "notice": "%{resource_name} was successfully destroyed."
      },
      "update": {
        "notice": "%{resource_name} was successfully updated."
      }
    }
  },
  "helpers": {
    "select": {
      "prompt": "Please select"
    },
    "submit": {
      "create": "Create %{model}",
      "submit": "Save %{model}",
      "update": "Update %{model}"
    }
  },
  "i18n": {
    "plural": {
      "keys": [
        "one",
        "other"
      ],
      "rule": "#<Proc:0x00007fe763ae7700 /home/pavel/.rvm/gems/ruby-3.1.2@media-gallery/gems/rails-i18n-7.0.6/lib/rails_i18n/common_pluralizations/one_other.rb:7 (lambda)>"
    },
    "transliterate": {
      "rule": "#<Proc:0x00007fe763ab4b98 /home/pavel/.rvm/gems/ruby-3.1.2@media-gallery/gems/rails-i18n-7.0.6/lib/rails_i18n/../../rails/transliteration/ru.rb:11 (lambda)>"
    }
  },
  "javascript": {
    "media_gallery": {
      "alert_box": {
        "delete": {
          "success": "Операция удаления успешно выполнена"
        },
        "post": {
          "success": "Операция загрузки успешно выполнена"
        },
        "put": {
          "success": "Операция обновления успешно выполнена"
        },
        "tips": {
          "error": "Ошибка операции",
          "success": "Операция успешно выполнена"
        }
      },
      "file": {
        "attributes": {
          "description": "Описание",
          "filesize": "Размер файла",
          "groupId": "ID группы",
          "groupName": "Наименование группы",
          "height": "Высота",
          "id": "ID",
          "name": "Наименование",
          "originalImage": "Ссылка на полноформатное изображение",
          "thumbnailImage": "Ссылка на эскиз",
          "url": "Ссылка на файл",
          "width": "Ширина"
        },
        "description": {
          "attributes": {
            "additional_info": "Дополнительная информация"
          },
          "file_uploaded": "Файл загружен. Сохраните изменения.",
          "url_copied": "Ссылка скопирована"
        },
        "files_not_selected": "Файлы не выбраны.",
        "import": {
          "modal_title": "Добавление нового файла",
          "placeholders": {
            "select_group_name": "Выберите название группы"
          },
          "upload": {
            "success": "Файл загружен успешно."
          },
          "upload_form": {
            "hint": "Поддержка однократной или массовой загрузки",
            "text": "Щелкните или перетащите файл в эту область для загрузки"
          }
        }
      },
      "folder": {
        "delete": "Удалить",
        "modal_title": "Создание группы",
        "placeholders": {
          "type_group_name": "Введите название группы"
        },
        "rename": "Переименовать"
      }
    }
  },
  "number": {
    "currency": {
      "format": {
        "delimiter": ",",
        "format": "%u%n",
        "precision": 2,
        "separator": ".",
        "significant": false,
        "strip_insignificant_zeros": false,
        "unit": "$"
      }
    },
    "format": {
      "delimiter": ",",
      "precision": 3,
      "round_mode": "default",
      "separator": ".",
      "significant": false,
      "strip_insignificant_zeros": false
    },
    "human": {
      "decimal_units": {
        "format": "%n %u",
        "units": {
          "billion": "Billion",
          "million": "Million",
          "quadrillion": "Quadrillion",
          "thousand": "Thousand",
          "trillion": "Trillion",
          "unit": ""
        }
      },
      "format": {
        "delimiter": "",
        "precision": 3,
        "significant": true,
        "strip_insignificant_zeros": true
      },
      "storage_units": {
        "format": "%n %u",
        "units": {
          "byte": {
            "few": "байта",
            "many": "байт",
            "one": "Byte",
            "other": "Bytes"
          },
          "eb": "EB",
          "gb": "GB",
          "kb": "KB",
          "mb": "MB",
          "pb": "PB",
          "tb": "TB"
        }
      }
    },
    "nth": {
      "ordinalized": "#<Proc:0x00007fe763adf550 /home/pavel/.rvm/gems/ruby-3.1.2@media-gallery/gems/activesupport-7.0.4/lib/active_support/locale/en.rb:26 (lambda)>",
      "ordinals": "#<Proc:0x00007fe763adf578 /home/pavel/.rvm/gems/ruby-3.1.2@media-gallery/gems/activesupport-7.0.4/lib/active_support/locale/en.rb:7 (lambda)>"
    },
    "percentage": {
      "format": {
        "delimiter": "",
        "format": "%n%"
      }
    },
    "precision": {
      "format": {
        "delimiter": ""
      }
    }
  },
  "support": {
    "array": {
      "last_word_connector": ", and ",
      "sentence_connector": "и",
      "skip_last_comma": true,
      "two_words_connector": " and ",
      "words_connector": ", "
    },
    "select": {
      "prompt": "Выберите: "
    }
  },
  "time": {
    "am": "am",
    "formats": {
      "default": "%a, %d %b %Y %H:%M:%S %z",
      "long": "%B %d, %Y %H:%M",
      "short": "%d %b %H:%M"
    },
    "pm": "pm"
  },
  "validation": {
    "errors": {
      "array?": "Не является массивом",
      "bool?": "Не является логическим значением",
      "excluded_from?": "Должно быть отличным от [%{list}]",
      "filled?": "Не может быть пустым",
      "float?": "Не является числом с плавающей запятой",
      "format?": "Имеет неверное значение",
      "gt?": "Должно быть больше чем %{num}",
      "gteq?": "Не может быть меньше %{num}",
      "included_in?": "Имеет неверное значение",
      "int?": "Не является числом",
      "key?": "Параметр отсутствует",
      "lteq?": "Не может быть больше %{num}",
      "max_size?": "Слишком большой длины (количество символов не должно превышать %{num})",
      "rules": {
        "category": {
          "not_exists": "Не может быть пустым"
        },
        "contract_files": {
          "invalid_format": "Неверный формат файла",
          "invalid_size": "Размер файлов не должен превышать %{max_size} байт. Текущий размер: %{current_size} байт"
        },
        "customer_id": {
          "filled?": "Не указан",
          "int?": "Не является числовым идентификатором клиента"
        },
        "description": {
          "completely_cleared": "Введены недопустимые символы"
        },
        "feedback_subcategory_id": {
          "not_exists": "Не может быть пустым"
        },
        "file": {
          "invalid_format": "Неверный формат файла",
          "max_size?": "Файл cлишком большой"
        },
        "id": {
          "int?": "Неправильный тип параметра или параметр отсутствует"
        },
        "item": {
          "file_already_exists": "Операцию произвести невозможно. Наименование и расширение загружаемого файла %{file_name} совпадают с уже имеющимся",
          "format_mismatch": "Несовпадение форматов",
          "invalid_format": "Неверный формат файла"
        },
        "media_gallery_group_id": {
          "not_exists": "Не может быть пустым",
          "not_found": "Не найдено"
        },
        "message": {
          "completely_cleared": "Введены недопустимые символы"
        },
        "model": {
          "invalid_model_name": "Неправильное имя модели",
          "missing_param": "Параметр отсутствует или значение пустое",
          "str?": "Неправильный тип параметра или параметр отсутствует"
        },
        "params": {
          "empty": "В запросе отсутствуют необходимые параметры"
        },
        "passport_files": {
          "invalid_format": "Неверный формат файла",
          "invalid_size": "Размер файлов не должен превышать %{max_size} байт. Текущий размер: %{current_size} байт"
        },
        "presentation/page": {
          "block_title": {
            "blank": "Название блока не может быть пустым"
          }
        },
        "queryParams": {
          "hash?": "В запросе отсутствуют необходимые параметры персонализации"
        },
        "question": {
          "completely_cleared": "Введены недопустимые символы"
        },
        "request": {
          "invalid": "Ошибка в запросе"
        },
        "taxpayer_id": {
          "invalid_length": "ИНН должен состоять строго из 10 или 12 цифр"
        },
        "token": {
          "filled?": "Не указан",
          "str?": "Не является строкой"
        }
      },
      "str?": "Не является строкой",
      "true?": "Не является истиной",
      "type?": "Неверный тип данных"
    }
  }
});
I18n.translations["ru"] = I18n.extend((I18n.translations["ru"] || {}), {
  "activerecord": {
    "errors": {
      "full_messages": {
        "format": "%{attribute} %{message}"
      },
      "messages": {
        "accepted": "нужно подтвердить",
        "blank": "не может быть пустым",
        "confirmation": "не совпадает с подтверждением",
        "empty": "не может быть пустым",
        "equal_to": "может иметь лишь значение, равное %{count}",
        "even": "может иметь лишь нечетное значение",
        "exclusion": "имеет зарезервированное значение",
        "greater_than": "может иметь лишь значение большее %{count}",
        "greater_than_or_equal_to": "может иметь лишь значение большее или равное %{count}",
        "inclusion": "имеет непредусмотренное значение",
        "invalid": "имеет неверное значение",
        "less_than": "может иметь лишь значение меньшее чем %{count}",
        "less_than_or_equal_to": "может иметь значение меньшее или равное %{count}",
        "not_a_number": "не является числом",
        "odd": "может иметь лишь четное значение",
        "record_invalid": "Возникли ошибки: %{errors}",
        "restrict_dependent_destroy": {
          "has_many": "Невозможно удалить запись, так как существуют зависимости: %{record}",
          "has_one": "Невозможно удалить запись, так как существует зависимость: %{record}"
        },
        "taken": "уже существует",
        "too_long": {
          "few": "слишком большой длины (не может быть больше чем %{count} символа)",
          "many": "слишком большой длины (не может быть больше чем %{count} символов)",
          "one": "слишком большой длины (не может быть больше чем %{count} символ)",
          "other": "слишком большой длины (не может быть больше чем %{count} символа)"
        },
        "too_short": {
          "few": "недостаточной длины (не может быть меньше %{count} символов)",
          "many": "недостаточной длины (не может быть меньше %{count} символов)",
          "one": "недостаточной длины (не может быть меньше %{count} символа)",
          "other": "недостаточной длины (не может быть меньше %{count} символа)"
        },
        "wrong_length": {
          "few": "неверной длины (может быть длиной ровно %{count} символа)",
          "many": "неверной длины (может быть длиной ровно %{count} символов)",
          "one": "неверной длины (может быть длиной ровно %{count} символ)",
          "other": "неверной длины (может быть длиной ровно %{count} символа)"
        }
      },
      "models": null,
      "template": {
        "body": "Проблемы возникли со следующими полями:",
        "header": {
          "few": "%{model}: сохранение не удалось из-за %{count} ошибок",
          "many": "%{model}: сохранение не удалось из-за %{count} ошибок",
          "one": "%{model}: сохранение не удалось из-за %{count} ошибки",
          "other": "%{model}: сохранение не удалось из-за %{count} ошибки"
        }
      }
    }
  },
  "date": {
    "abbr_day_names": [
      "Вс",
      "Пн",
      "Вт",
      "Ср",
      "Чт",
      "Пт",
      "Сб"
    ],
    "abbr_month_names": [
      null,
      "янв.",
      "февр.",
      "марта",
      "апр.",
      "мая",
      "июня",
      "июля",
      "авг.",
      "сент.",
      "окт.",
      "нояб.",
      "дек."
    ],
    "common_abbr_day_names": [
      "Вс",
      "Пн",
      "Вт",
      "Ср",
      "Чт",
      "Пт",
      "Сб"
    ],
    "common_abbr_month_names": [
      null,
      "янв.",
      "февр.",
      "марта",
      "апр.",
      "мая",
      "июня",
      "июля",
      "авг.",
      "сент.",
      "окт.",
      "нояб.",
      "дек."
    ],
    "common_day_names": [
      "воскресенье",
      "понедельник",
      "вторник",
      "среда",
      "четверг",
      "пятница",
      "суббота"
    ],
    "common_month_names": [
      null,
      "января",
      "февраля",
      "марта",
      "апреля",
      "мая",
      "июня",
      "июля",
      "августа",
      "сентября",
      "октября",
      "ноября",
      "декабря"
    ],
    "day_names": [
      "воскресенье",
      "понедельник",
      "вторник",
      "среда",
      "четверг",
      "пятница",
      "суббота"
    ],
    "formats": {
      "default": "%d.%m.%Y",
      "long": "%-d %B %Y",
      "short": "%-d %b"
    },
    "month_names": [
      null,
      "января",
      "февраля",
      "марта",
      "апреля",
      "мая",
      "июня",
      "июля",
      "августа",
      "сентября",
      "октября",
      "ноября",
      "декабря"
    ],
    "order": [
      "day",
      "month",
      "year"
    ],
    "standalone_abbr_day_names": [
      "вс",
      "пн",
      "вт",
      "ср",
      "чт",
      "пт",
      "сб"
    ],
    "standalone_abbr_month_names": [
      null,
      "янв.",
      "февр.",
      "март",
      "апр.",
      "май",
      "июнь",
      "июль",
      "авг.",
      "сент.",
      "окт.",
      "нояб.",
      "дек."
    ],
    "standalone_day_names": [
      "Воскресенье",
      "Понедельник",
      "Вторник",
      "Среда",
      "Четверг",
      "Пятница",
      "Суббота"
    ],
    "standalone_month_names": [
      null,
      "Январь",
      "Февраль",
      "Март",
      "Апрель",
      "Май",
      "Июнь",
      "Июль",
      "Август",
      "Сентябрь",
      "Октябрь",
      "Ноябрь",
      "Декабрь"
    ]
  },
  "datetime": {
    "distance_in_words": {
      "about_x_hours": {
        "few": "около %{count} часов",
        "many": "около %{count} часов",
        "one": "около %{count} часа",
        "other": "около %{count} часа"
      },
      "about_x_months": {
        "few": "около %{count} месяцев",
        "many": "около %{count} месяцев",
        "one": "около %{count} месяца",
        "other": "около %{count} месяца"
      },
      "about_x_years": {
        "few": "около %{count} лет",
        "many": "около %{count} лет",
        "one": "около %{count} года",
        "other": "около %{count} лет"
      },
      "almost_x_years": {
        "few": "почти %{count} года",
        "many": "почти %{count} лет",
        "one": "почти 1 год",
        "other": "почти %{count} лет"
      },
      "half_a_minute": "полминуты",
      "less_than_x_minutes": {
        "few": "меньше %{count} минут",
        "many": "меньше %{count} минут",
        "one": "меньше %{count} минуты",
        "other": "меньше %{count} минуты"
      },
      "less_than_x_seconds": {
        "few": "меньше %{count} секунд",
        "many": "меньше %{count} секунд",
        "one": "меньше %{count} секунды",
        "other": "меньше %{count} секунды"
      },
      "over_x_years": {
        "few": "больше %{count} лет",
        "many": "больше %{count} лет",
        "one": "больше %{count} года",
        "other": "больше %{count} лет"
      },
      "x_days": {
        "few": "%{count} дня",
        "many": "%{count} дней",
        "one": "%{count} день",
        "other": "%{count} дня"
      },
      "x_minutes": {
        "few": "%{count} минуты",
        "many": "%{count} минут",
        "one": "%{count} минуту",
        "other": "%{count} минуты"
      },
      "x_months": {
        "few": "%{count} месяца",
        "many": "%{count} месяцев",
        "one": "%{count} месяц",
        "other": "%{count} месяца"
      },
      "x_seconds": {
        "few": "%{count} секунды",
        "many": "%{count} секунд",
        "one": "%{count} секунду",
        "other": "%{count} секунды"
      },
      "x_years": {
        "few": "%{count} года",
        "many": "%{count} лет",
        "one": "%{count} год",
        "other": "%{count} года"
      }
    },
    "prompts": {
      "day": "День",
      "hour": "Часов",
      "minute": "Минут",
      "month": "Месяц",
      "second": "Секунд",
      "year": "Год"
    }
  },
  "errors": {
    "format": "%{attribute} %{message}",
    "messages": {
      "accepted": "нужно подтвердить",
      "blank": "не может быть пустым",
      "confirmation": "не совпадает со значением поля %{attribute}",
      "empty": "не может быть пустым",
      "equal_to": "может иметь лишь значение, равное %{count}",
      "even": "может иметь лишь четное значение",
      "exclusion": "имеет зарезервированное значение",
      "greater_than": "может иметь значение большее %{count}",
      "greater_than_or_equal_to": "может иметь значение большее или равное %{count}",
      "inclusion": "имеет непредусмотренное значение",
      "invalid": "имеет неверное значение",
      "less_than": "может иметь значение меньшее чем %{count}",
      "less_than_or_equal_to": "может иметь значение меньшее или равное %{count}",
      "model_invalid": "Возникли ошибки: %{errors}",
      "not_a_number": "не является числом",
      "not_an_integer": "не является целым числом",
      "odd": "может иметь лишь нечетное значение",
      "other_than": "должно отличаться от %{count}",
      "present": "нужно оставить пустым",
      "record_invalid": "Возникли ошибки: %{errors}",
      "required": "не может отсутствовать",
      "taken": "уже существует",
      "too_long": {
        "few": "слишком большой длины (не может быть больше чем %{count} символа)",
        "many": "слишком большой длины (не может быть больше чем %{count} символов)",
        "one": "слишком большой длины (не может быть больше чем %{count} символ)",
        "other": "слишком большой длины (не может быть больше чем %{count} символа)"
      },
      "too_short": {
        "few": "недостаточной длины (не может быть меньше %{count} символов)",
        "many": "недостаточной длины (не может быть меньше %{count} символов)",
        "one": "недостаточной длины (не может быть меньше %{count} символа)",
        "other": "недостаточной длины (не может быть меньше %{count} символа)"
      },
      "wrong_length": {
        "few": "неверной длины (может быть длиной ровно %{count} символа)",
        "many": "неверной длины (может быть длиной ровно %{count} символов)",
        "one": "неверной длины (может быть длиной ровно %{count} символ)",
        "other": "неверной длины (может быть длиной ровно %{count} символа)"
      }
    },
    "template": {
      "body": "Проблемы возникли со следующими полями:",
      "header": {
        "few": "%{model}: сохранение не удалось из-за %{count} ошибок",
        "many": "%{model}: сохранение не удалось из-за %{count} ошибок",
        "one": "%{model}: сохранение не удалось из-за %{count} ошибки",
        "other": "%{model}: сохранение не удалось из-за %{count} ошибки"
      }
    }
  },
  "helpers": {
    "select": {
      "prompt": "Выберите: "
    },
    "submit": {
      "create": "Создать %{model}",
      "submit": "Сохранить %{model}",
      "update": "Сохранить %{model}"
    }
  },
  "i18n": {
    "plural": {
      "keys": [
        "one",
        "few",
        "many",
        "other"
      ],
      "rule": "#<Proc:0x00007fe763ae1120 /home/pavel/.rvm/gems/ruby-3.1.2@media-gallery/gems/rails-i18n-7.0.6/lib/rails_i18n/common_pluralizations/east_slavic.rb:16 (lambda)>"
    },
    "transliterate": {
      "rule": "#<Proc:0x00007fe763ab4b98 /home/pavel/.rvm/gems/ruby-3.1.2@media-gallery/gems/rails-i18n-7.0.6/lib/rails_i18n/../../rails/transliteration/ru.rb:11 (lambda)>"
    }
  },
  "javascript": {
    "media_gallery": {
      "alert_box": {
        "delete": {
          "success": "Операция удаления успешно выполнена"
        },
        "post": {
          "success": "Операция загрузки успешно выполнена"
        },
        "put": {
          "success": "Операция обновления успешно выполнена"
        },
        "tips": {
          "error": "Ошибка операции",
          "success": "Операция успешно выполнена"
        }
      },
      "file": {
        "attributes": {
          "description": "Описание",
          "filesize": "Размер файла",
          "groupId": "ID группы",
          "groupName": "Наименование группы",
          "height": "Высота",
          "id": "ID",
          "name": "Наименование",
          "originalImage": "Ссылка на полноформатное изображение",
          "thumbnailImage": "Ссылка на эскиз",
          "url": "Ссылка на файл",
          "width": "Ширина"
        },
        "description": {
          "attributes": {
            "additional_info": "Дополнительная информация"
          },
          "file_uploaded": "Файл загружен. Сохраните изменения.",
          "url_copied": "Ссылка скопирована"
        },
        "files_not_selected": "Файлы не выбраны.",
        "import": {
          "modal_title": "Добавление нового файла",
          "placeholders": {
            "select_group_name": "Выберите название группы"
          },
          "upload": {
            "success": "Файл загружен успешно."
          },
          "upload_form": {
            "hint": "Поддержка однократной или массовой загрузки",
            "text": "Щелкните или перетащите файл в эту область для загрузки"
          }
        }
      },
      "folder": {
        "delete": "Удалить",
        "modal_title": "Создание группы",
        "placeholders": {
          "type_group_name": "Введите название группы"
        },
        "rename": "Переименовать"
      }
    }
  },
  "number": {
    "currency": {
      "format": {
        "delimiter": " ",
        "format": "%n %u",
        "precision": 2,
        "separator": ",",
        "significant": false,
        "strip_insignificant_zeros": false,
        "unit": "руб."
      }
    },
    "format": {
      "delimiter": " ",
      "precision": 3,
      "separator": ",",
      "significant": false,
      "strip_insignificant_zeros": false
    },
    "human": {
      "decimal_units": {
        "format": "%n %u",
        "units": {
          "billion": {
            "few": "миллиардов",
            "many": "миллиардов",
            "one": "миллиард",
            "other": "миллиардов"
          },
          "million": {
            "few": "миллионов",
            "many": "миллионов",
            "one": "миллион",
            "other": "миллионов"
          },
          "quadrillion": {
            "few": "квадриллионов",
            "many": "квадриллионов",
            "one": "квадриллион",
            "other": "квадриллионов"
          },
          "thousand": {
            "few": "тысяч",
            "many": "тысяч",
            "one": "тысяча",
            "other": "тысяч"
          },
          "trillion": {
            "few": "триллионов",
            "many": "триллионов",
            "one": "триллион",
            "other": "триллионов"
          },
          "unit": ""
        }
      },
      "format": {
        "delimiter": "",
        "precision": 1,
        "significant": false,
        "strip_insignificant_zeros": false
      },
      "storage_units": {
        "format": "%n %u",
        "units": {
          "byte": {
            "few": "байта",
            "many": "байт",
            "one": "байт",
            "other": "байта"
          },
          "eb": "ЭБ",
          "gb": "ГБ",
          "kb": "КБ",
          "mb": "МБ",
          "pb": "ПБ",
          "tb": "ТБ"
        }
      }
    },
    "percentage": {
      "format": {
        "delimiter": "",
        "format": "%n%"
      }
    },
    "precision": {
      "format": {
        "delimiter": ""
      }
    }
  },
  "support": {
    "array": {
      "last_word_connector": " и ",
      "sentence_connector": "и",
      "skip_last_comma": true,
      "two_words_connector": " и ",
      "words_connector": ", "
    },
    "select": {
      "prompt": "Выберите: "
    }
  },
  "time": {
    "am": "утра",
    "formats": {
      "default": "%a, %d %b %Y, %H:%M:%S %z",
      "long": "%d %B %Y, %H:%M",
      "short": "%d %b, %H:%M"
    },
    "pm": "вечера"
  },
  "validation": {
    "errors": {
      "array?": "Не является массивом",
      "bool?": "Не является логическим значением",
      "excluded_from?": "Должно быть отличным от [%{list}]",
      "filled?": "Не может быть пустым",
      "float?": "Не является числом с плавающей запятой",
      "format?": "Имеет неверное значение",
      "gt?": "Должно быть больше чем %{num}",
      "gteq?": "Не может быть меньше %{num}",
      "included_in?": "Имеет неверное значение",
      "int?": "Не является числом",
      "key?": "Параметр отсутствует",
      "lteq?": "Не может быть больше %{num}",
      "max_size?": "Слишком большой длины (количество символов не должно превышать %{num})",
      "rules": {
        "category": {
          "not_exists": "Не может быть пустым"
        },
        "contract_files": {
          "invalid_format": "Неверный формат файла",
          "invalid_size": "Размер файлов не должен превышать %{max_size} байт. Текущий размер: %{current_size} байт"
        },
        "customer_id": {
          "filled?": "Не указан",
          "int?": "Не является числовым идентификатором клиента"
        },
        "description": {
          "completely_cleared": "Введены недопустимые символы"
        },
        "feedback_subcategory_id": {
          "not_exists": "Не может быть пустым"
        },
        "file": {
          "invalid_format": "Неверный формат файла",
          "max_size?": "Файл cлишком большой"
        },
        "id": {
          "int?": "Неправильный тип параметра или параметр отсутствует"
        },
        "item": {
          "file_already_exists": "Операцию произвести невозможно. Наименование и расширение загружаемого файла %{file_name} совпадают с уже имеющимся",
          "format_mismatch": "Несовпадение форматов",
          "invalid_format": "Неверный формат файла"
        },
        "media_gallery_group_id": {
          "not_exists": "Не может быть пустым",
          "not_found": "Не найдено"
        },
        "message": {
          "completely_cleared": "Введены недопустимые символы"
        },
        "model": {
          "invalid_model_name": "Неправильное имя модели",
          "missing_param": "Параметр отсутствует или значение пустое",
          "str?": "Неправильный тип параметра или параметр отсутствует"
        },
        "params": {
          "empty": "В запросе отсутствуют необходимые параметры"
        },
        "passport_files": {
          "invalid_format": "Неверный формат файла",
          "invalid_size": "Размер файлов не должен превышать %{max_size} байт. Текущий размер: %{current_size} байт"
        },
        "presentation/page": {
          "block_title": {
            "blank": "Название блока не может быть пустым"
          }
        },
        "queryParams": {
          "hash?": "В запросе отсутствуют необходимые параметры персонализации"
        },
        "question": {
          "completely_cleared": "Введены недопустимые символы"
        },
        "request": {
          "invalid": "Ошибка в запросе"
        },
        "taxpayer_id": {
          "invalid_length": "ИНН должен состоять строго из 10 или 12 цифр"
        },
        "token": {
          "filled?": "Не указан",
          "str?": "Не является строкой"
        }
      },
      "str?": "Не является строкой",
      "true?": "Не является истиной",
      "type?": "Неверный тип данных"
    }
  }
});
