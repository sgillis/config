def pstring(value, prefix="", in_list=False):
    if isinstance(value, dict):
        string = pstring_dict(value, prefix=prefix)
    elif isinstance(value, list):
        string = pstring_list(value, prefix=prefix)
    else:
        try:
            string = str(value)
        except:
            string = "Unable to print type " + str(type(value))
    if in_list:
        string = string + ",\n"
    else:
        string = string + "\n"
    return string


def pstring_list(l, prefix=""):
    string = '\n' + prefix + "[\n"
    for e in l:
        string += prefix + '\t' + pstring(e, prefix=prefix+"\t", in_list=True)
    string += prefix + "]"
    return string

def pstring_dict(d, prefix=""):
    string = '\n' + prefix + "{\n"
    for key, value in d.iteritems():
        string += prefix + "\t" + str(key) + ": " + pstring(value, prefix=prefix+"\t")
    string += prefix + "}"
    return string
